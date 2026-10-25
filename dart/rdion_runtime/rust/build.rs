fn main() {
    println!("cargo:rerun-if-changed=build.rs");
    // unrar_sys builds C++ with `.cpp_link_stdlib(None)` and the final link is
    // driven by the NDK clang (C driver), so libc++ symbols stay undefined in
    // the cdylib. MSVC paperes over this via embedded /DEFAULTLIB directives,
    // but Android's dynamic linker refuses the library at dlopen time
    // (UnsatisfiedLinkError: _ZTISt12length_error...). Embed the NDK's static
    // libc++ so the .so is self-contained.
    if std::env::var("CARGO_CFG_TARGET_OS").as_deref() == Ok("android") {
        // No `static=` kind: rustc would pre-check its own -L paths and fail;
        // the NDK clang driver resolves these from its sysroot and only the
        // .a variants exist under these names.
        println!("cargo:rustc-link-lib=c++_static");
        println!("cargo:rustc-link-lib=c++abi");
    }
}
