set -e

# we run this script to pull in the rustc crates we depend on and then we have to check them in because cargo tries to resolve dependencies before invoking our build script...

readonly rustc_crates_dir="rustc_crates"
readonly sysroot="$(cargo rustc -Z unstable-options --print sysroot)"
readonly compiler_components_dir="${sysroot}/lib/rustlib/rustc-src/rust/compiler"

mkdir -p "${rustc_crates_dir}"
cp -r ${compiler_components_dir}/* "${rustc_crates_dir}"

# patch rustc_target for wasm
patch rustc_crates/rustc_target/src/abi/mod.rs < rustc_target_abi_mod.patch
