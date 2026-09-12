package dion.mihon

import io.github.oshai.kotlinlogging.KotlinLogging
import org.objectweb.asm.ClassReader
import org.objectweb.asm.ClassVisitor
import org.objectweb.asm.ClassWriter
import org.objectweb.asm.FieldVisitor
import org.objectweb.asm.MethodVisitor
import org.objectweb.asm.Opcodes
import java.nio.file.FileSystems
import java.nio.file.Files
import java.nio.file.Path
import java.nio.file.StandardOpenOption
import kotlin.streams.asSequence

/**
 * Bytecode editor that replaces certain Java class references with 
 * Android-compatible replacements when loading Mihon extensions.
 * 
 * This is needed because Android's SimpleDateFormat (and other classes)
 * behave differently than the JDK versions. Extensions compiled for Android
 * expect Android behavior, so we redirect these classes to our compat implementations.
 */
object BytecodeEditor {
    private val logger = KotlinLogging.logger {}

    /**
     * Replace Java class references inside a JAR with Android-compatible replacements.
     *
     * @param jarFile The JAR file to modify
     */
    fun fixAndroidClasses(jarFile: Path) {
        try {
            FileSystems.newFileSystem(jarFile, null as ClassLoader?)?.use { fs ->
                val entries = Files
                    .walk(fs.getPath("/"))
                    .asSequence()
                    .filterNotNull()
                    .filterNot(Files::isDirectory)
                    .mapNotNull(::getClassBytes)
                    .toList()

                val invokeFix = InvokeKindFix(entries)

                entries
                    .map { transform(it, invokeFix) }
                    .forEach { write(it) }
            }
        } catch (e: Exception) {
            logger.error(e) { "Error fixing Android classes in: $jarFile" }
        }
    }

    /**
     * Repairs invoke opcodes whose owner kind (class vs interface) does not
     * match the instruction kind.
     *
     * R8 emits `invoke-super` calls to interface default methods and other
     * class/interface-merging artifacts; dex2jar translates them with a plain
     * method reference (`itf = false`), which the JVM rejects at execution
     * with `IncompatibleClassChangeError: Method '…' must be InterfaceMethodref
     * constant`. Owners are classified either from the converted jar itself
     * (when the class is jar-local) or from the runtime classpath.
     */
    private class InvokeKindFix(entries: List<Pair<Path, ByteArray>>) {
        private val interfaces: Set<String> = buildSet {
            for ((_, bytes) in entries) {
                val cr = ClassReader(bytes)
                if (cr.access and Opcodes.ACC_INTERFACE != 0) add(cr.className)
            }
        }
        private val classes: Set<String> = buildSet {
            for ((_, bytes) in entries) {
                val cr = ClassReader(bytes)
                if (cr.access and Opcodes.ACC_INTERFACE == 0) add(cr.className)
            }
        }

        private val externalKinds = HashMap<String, Boolean?>()

        /** True when `owner` names an interface, false when a class, null when unknown. */
        private fun isInterface(owner: String): Boolean? {
            if (owner in interfaces) return true
            if (owner in classes) return false
            if (externalKinds.containsKey(owner)) return externalKinds[owner]
            // External owner: consult the runtime classpath without initializing.
            val kind = try {
                Class.forName(owner.replace('/', '.'), false, BytecodeEditor::class.java.classLoader)
                    .isInterface
            } catch (_: Throwable) {
                null
            }
            externalKinds[owner] = kind
            return kind
        }

        /** Returns adjusted (opcode, itf) for a method call on `owner`. */
        fun fix(opcode: Int, owner: String?, itf: Boolean): Pair<Int, Boolean> {
            if (owner == null) return opcode to itf
            return when (isInterface(owner)) {
                true -> when (opcode) {
                    Opcodes.INVOKEINTERFACE -> opcode to true
                    Opcodes.INVOKEVIRTUAL -> Opcodes.INVOKEINTERFACE to true
                    else -> opcode to true // invokespecial/invokestatic on an interface method
                }
                false -> when (opcode) {
                    Opcodes.INVOKEINTERFACE -> Opcodes.INVOKEVIRTUAL to false
                    else -> opcode to false
                }
                null -> opcode to itf // unknown owner: leave untouched
            }
        }
    }

    /**
     * Get class bytes from a Path
     *
     * @param path The path to the class file
     * @return Pair of Path and ByteArray, or null if not a valid class
     */
    private fun getClassBytes(path: Path): Pair<Path, ByteArray>? {
        return try {
            if (path.toString().endsWith(".class")) {
                val bytes = Files.readAllBytes(path)
                if (bytes.size < 4) {
                    return null
                }
                // Check for CAFEBABE magic number
                val magic = String.format(
                    "%02X%02X%02X%02X",
                    bytes[0], bytes[1], bytes[2], bytes[3]
                )
                if (magic.lowercase() != "cafebabe") {
                    return null
                }
                path to bytes
            } else {
                null
            }
        } catch (e: Exception) {
            logger.debug(e) { "Error loading class: $path" }
            null
        }
    }

    /**
     * Path prefix for replacement classes
     */
    private const val REPLACEMENT_PATH = "dion/mihon/android/replace"

    /**
     * Classes that should be replaced with Android-compatible versions
     */
    private val classesToReplace = listOf(
        "java/text/SimpleDateFormat",
    )

    /**
     * Replace direct class references
     */
    private fun String?.replaceDirectly() =
        when (this) {
            null -> null
            in classesToReplace -> "$REPLACEMENT_PATH/$this"
            else -> this
        }

    /**
     * Replace indirect class references (in descriptors, signatures, etc.)
     */
    private fun String?.replaceIndirectly(): String? {
        if (this == null) return null
        var result: String = this
        classesToReplace.forEach { toReplace ->
            result = result.replace(toReplace, "$REPLACEMENT_PATH/$toReplace")
        }
        return result
    }

    /**
     * Transform a class by replacing Android-incompatible references
     */
    private fun transform(pair: Pair<Path, ByteArray>, invokeFix: InvokeKindFix): Pair<Path, ByteArray> {
        val cr = ClassReader(pair.second)
        val cw = ClassWriter(cr, 0)
        
        cr.accept(object : ClassVisitor(Opcodes.ASM5, cw) {
            override fun visitField(
                access: Int,
                name: String?,
                desc: String?,
                signature: String?,
                cst: Any?
            ): FieldVisitor? {
                return super.visitField(access, name, desc.replaceIndirectly(), signature, cst)
            }

            override fun visitMethod(
                access: Int,
                name: String,
                desc: String,
                signature: String?,
                exceptions: Array<String?>?
            ): MethodVisitor {
                val mv = super.visitMethod(
                    access,
                    name,
                    desc.replaceIndirectly(),
                    signature,
                    exceptions
                )
                return object : MethodVisitor(Opcodes.ASM5, mv) {
                    override fun visitTypeInsn(opcode: Int, type: String?) {
                        super.visitTypeInsn(opcode, type.replaceDirectly())
                    }

                    override fun visitMethodInsn(
                        opcode: Int,
                        owner: String?,
                        name: String?,
                        desc: String?,
                        itf: Boolean
                    ) {
                        val (fixedOpcode, fixedItf) = invokeFix.fix(opcode, owner, itf)
                        super.visitMethodInsn(
                            fixedOpcode,
                            owner.replaceDirectly(),
                            name,
                            desc.replaceIndirectly(),
                            fixedItf
                        )
                    }

                    override fun visitFieldInsn(
                        opcode: Int,
                        owner: String?,
                        name: String?,
                        desc: String?
                    ) {
                        super.visitFieldInsn(opcode, owner, name, desc.replaceIndirectly())
                    }
                }
            }
        }, 0)
        
        return pair.first to cw.toByteArray()
    }

    /**
     * Write modified class bytes back to the JAR
     */
    private fun write(pair: Pair<Path, ByteArray>) {
        Files.write(
            pair.first,
            pair.second,
            StandardOpenOption.CREATE,
            StandardOpenOption.TRUNCATE_EXISTING
        )
    }
}
