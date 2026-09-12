package dion.mihon

import com.googlecode.d2j.Method
import com.googlecode.d2j.dex.writer.DexFileWriter
import com.googlecode.d2j.node.DexClassNode
import com.googlecode.d2j.node.DexCodeNode
import com.googlecode.d2j.node.DexFileNode
import com.googlecode.d2j.node.DexMethodNode
import com.googlecode.d2j.node.insn.ConstStmtNode
import com.googlecode.d2j.node.insn.DexStmtNode
import com.googlecode.d2j.node.insn.FieldStmtNode
import com.googlecode.d2j.node.insn.MethodStmtNode
import com.googlecode.d2j.node.insn.Stmt0RNode
import com.googlecode.d2j.node.insn.Stmt1RNode
import com.googlecode.d2j.node.insn.Stmt2R1NNode
import com.googlecode.d2j.node.insn.Stmt2RNode
import com.googlecode.d2j.node.insn.Stmt3RNode
import com.googlecode.d2j.node.insn.TypeStmtNode
import com.googlecode.d2j.reader.BaseDexFileReader
import com.googlecode.d2j.reader.MultiDexFileReader
import com.googlecode.d2j.reader.Op
import io.github.oshai.kotlinlogging.KotlinLogging

/**
 * Repairs R8's inlined-constructor pattern before dex2jar conversion.
 *
 * R8 removes trivial constructors and rewrites their call sites to invoke the
 * *superclass* constructor directly on the `new-instance`-created object:
 *
 * ```smali
 * new-instance v0, Lq;                       # q extends Lambda, q.<init> removed
 * const/4 v1, 0
 * invoke-direct {v0, v1}, Lkotlin/jvm/internal/Lambda;-><init>(I)V
 * ```
 *
 * This is valid DEX, but dex2jar pairs `NEW` with the `<init>` owner, so it
 * emits `NEW kotlin/jvm/internal/Lambda` (or `NEW java/lang/Object`) instead of
 * `NEW q`. On the JVM this surfaces as `InstantiationError` (abstract
 * superclass such as Lambda/Enum) or as a bare `java.lang.Object` instance
 * reaching a call site (`ClassCastException`) — the failure mode behind most
 * "install failed / compat failed" extensions built with recent R8 templates.
 *
 * The fixer rewrites those `invoke-direct` owners back to the class named by
 * the dominating `new-instance`, and synthesizes the missing trivial
 * constructor (`X.<init>(…) { super(…); }`) on the target class so the
 * rewritten call resolves.
 *
 * Register tracking is a linear last-definition scan that survives branches:
 * the DEX verifier guarantees that an `invoke-direct <init>` operand always
 * holds the uninitialized instance of a *dominating* `new-instance`, so the
 * last definition of the register in program order is the intended class on
 * every path that reaches the call. As an extra guard against register reuse
 * across branches, a rewrite is only applied when the call's owner is on the
 * intended class's superclass chain.
 *
 * Unknown patterns are left untouched, so the transformation is a no-op for
 * extensions that do not use the pattern.
 */
object InlinedConstructorFixer {
    private val logger = KotlinLogging.logger {}

    /** Method access flags for a public constructor. */
    private const val ACC_PUBLIC: Int = 0x1
    private const val ACC_CONSTRUCTOR: Int = 0x10000

    /** Max register operands of the non-range invoke formats. */
    private const val MAX_INVOKE_ARGS: Int = 5

    /** Guard against superclass-chain cycles in malformed input. */
    private const val MAX_SUPER_HOPS: Int = 100

    /** One `invoke-direct Super.<init>` to rewrite back onto `intended`. */
    private class Rewrite(
        val stmts: MutableList<DexStmtNode>,
        val index: Int,
        val op: Op,
        val args: IntArray,
        val intended: String,
        val superCtor: Method,
    )

    /**
     * Rewrite the dex stream, returning a reader over the patched dex.
     * Returns the original reader when nothing needed patching or when the
     * rewrite fails for any reason (the unpatched conversion still runs).
     */
    fun fix(reader: BaseDexFileReader): BaseDexFileReader {
        return try {
            fixOrOriginal(reader)
        } catch (e: Exception) {
            logger.warn(e) { "inlined-constructor fix failed; converting unpatched dex" }
            reader
        }
    }

    private fun fixOrOriginal(reader: BaseDexFileReader): BaseDexFileReader {
        val node = DexFileNode()
        reader.accept(node)
        val byName: Map<String, DexClassNode> = node.clzs.associateBy { it.className }
        // Constructors already declared per class, by descriptor.
        val declaredCtors: Map<String, Set<String>> = node.clzs.associate { cn ->
            cn.className to cn.methods.orEmpty()
                .filter { it.method.name == "<init>" }
                .mapTo(HashSet()) { it.method.desc }
        }

        val rewrites = ArrayList<Rewrite>()
        for (cn in node.clzs) {
            for (mn in cn.methods.orEmpty()) {
                val code: DexCodeNode = mn.codeNode ?: continue
                val stmts = code.stmts as? MutableList<DexStmtNode> ?: continue
                // Register -> class of the last new-instance that defined it.
                val pending = HashMap<Int, String>()
                for (i in stmts.indices) {
                    val st = stmts[i]
                    when (st) {
                        is TypeStmtNode -> when (st.op) {
                            Op.NEW_INSTANCE -> pending[st.a] = st.type
                            Op.INSTANCE_OF -> pending.remove(st.a)
                            else -> {}
                        }
                        is MethodStmtNode -> {
                            if ((st.op == Op.INVOKE_DIRECT || st.op == Op.INVOKE_DIRECT_RANGE) &&
                                st.method.name == "<init>" &&
                                st.args.isNotEmpty()
                            ) {
                                val intended = pending[st.args[0]]
                                if (intended != null &&
                                    intended != st.method.owner &&
                                    byName.containsKey(intended) &&
                                    superChainContains(st.method.owner, intended, byName)
                                ) {
                                    rewrites += Rewrite(
                                        stmts = stmts,
                                        index = i,
                                        op = st.op,
                                        args = st.args,
                                        intended = intended,
                                        superCtor = st.method,
                                    )
                                }
                                pending.remove(st.args[0])
                            }
                        }
                        // Every other register-defining shape invalidates the
                        // tracked new-instance for its destination register.
                        is ConstStmtNode -> pending.remove(st.a)
                        is Stmt1RNode -> pending.remove(st.a) // move-result, move-exception, …
                        is Stmt2RNode -> pending.remove(st.a) // moves, aget (3R below), 2addr ops
                        is Stmt3RNode -> pending.remove(st.a) // aget/cmp families
                        is Stmt2R1NNode -> pending.remove(st.distReg) // binop/lit8
                        is FieldStmtNode -> pending.remove(st.a) // sget (conservative for sput)
                        else -> {}
                    }
                }
            }
        }
        if (rewrites.isEmpty()) return reader

        // Apply the rewrites and remember which constructors must be synthesized.
        // className -> (ctor descriptor -> super ctor)
        val synth = LinkedHashMap<String, LinkedHashMap<String, Method>>()
        for (rw in rewrites) {
            rw.stmts[rw.index] = MethodStmtNode(
                rw.op,
                rw.args,
                Method(rw.intended, "<init>", rw.superCtor.proto),
            )
            if (declaredCtors[rw.intended]?.contains(rw.superCtor.desc) != true) {
                synth.getOrPut(rw.intended) { LinkedHashMap() }[rw.superCtor.desc] = rw.superCtor
            }
        }

        // Synthesize the missing trivial constructors: X.<init>(…) { super(…); }
        // R8 strips whole constructor chains (X → super → grand-super …), so
        // intermediate superclasses may need synthesized constructors too,
        // each forwarding to its own superclass until an existing constructor
        // (or an external class — the original call target) is reached.
        for ((className, ctorsToSynth) in synth.toMap()) {
            for ((_, superCtor) in ctorsToSynth.toList()) {
                var cur: DexClassNode = byName.getValue(className)
                var hops = 0
                while (hops < MAX_SUPER_HOPS) {
                    hops++
                    val superName = cur.superClass ?: break
                    val superClassNode: DexClassNode = byName[superName] ?: break
                    if (declaredCtors[superName]?.contains(superCtor.desc) == true) break
                    if (synth.getOrPut(superName) { LinkedHashMap() }.containsKey(superCtor.desc)) break
                    synth.getValue(superName)[superCtor.desc] = superCtor
                    cur = superClassNode
                }
            }
        }
        for ((className, ctorsToSynth) in synth) {
            val cn: DexClassNode = byName.getValue(className)
            val superCls = cn.superClass
            for ((_, superCtor) in ctorsToSynth) {
                val params = superCtor.parameterTypes
                var reg = 1
                val regs = mutableListOf(0)
                for (p in params) {
                    regs += reg
                    reg += if (p == "J" || p == "D") 2 else 1
                }
                // The /range format addresses consecutive registers only, so
                // for wide parameters every covered register (including the
                // second half of J/D) must appear in the list.
                val callOp = if (regs.size > MAX_INVOKE_ARGS) Op.INVOKE_DIRECT_RANGE else Op.INVOKE_DIRECT
                val callRegs = if (callOp == Op.INVOKE_DIRECT_RANGE) IntArray(reg) { it } else regs.toIntArray()
                val ctor = DexMethodNode(
                    ACC_PUBLIC or ACC_CONSTRUCTOR,
                    Method(className, "<init>", params, "V"),
                )
                ctor.codeNode = DexCodeNode().apply {
                    totalRegister = reg
                    stmts = mutableListOf(
                        MethodStmtNode(callOp, callRegs, Method(superCls, "<init>", superCtor.proto)),
                        Stmt0RNode(Op.RETURN_VOID),
                    )
                }
                if (cn.methods == null) cn.methods = ArrayList()
                cn.methods!!.add(ctor)
            }
        }

        val writer = DexFileWriter()
        node.accept(writer)
        logger.info {
            "rewrote ${rewrites.size} inlined constructor call(s), " +
                "synthesized ${synth.values.sumOf { it.size }} constructor(s)"
        }
        return MultiDexFileReader.open(writer.toByteArray())
    }

    /**
     * Whether `owner` is a (transitive) superclass of `cls`, following the
     * superclass chain through classes that live in this dex. The chain walk
     * stops at the first external class, which is still compared by name.
     */
    private fun superChainContains(owner: String, cls: String, byName: Map<String, DexClassNode>): Boolean {
        var cur: String? = byName[cls]?.superClass
        var hops = 0
        while (cur != null && hops < MAX_SUPER_HOPS) {
            if (cur == owner) return true
            cur = byName[cur]?.superClass
            hops++
        }
        return false
    }
}
