# Cross compiling a Rust project using Devenv

This is the smallest example repo to demonstrate an issue with cross-compling a Rust project on my MBP M3 with target `aarch64-unknown-linux-gnu`.

For the linker I used

```
brew tap messense/macos-cross-toolchains
brew install aarch64-unknown-linux-gnu
```

as I couldn't figure out how to make this available for cross-compilation only using devenv/nix.

The error seems to be related to a `CFLAGS` env var that gets set:

```
he following warnings were emitted during compilation:

warning: ring@0.17.8: aarch64-unknown-linux-gnu-gcc: error: unrecognized command-line option '-iframework'

error: failed to run custom build command for `ring v0.17.8`

Caused by:
  process didn't exit successfully: `/Users/bas/cross/target/debug/build/ring-d63e213e7a2a66ad/build-script-build` (exit status: 1)
  --- stdout
  cargo:rerun-if-env-changed=RING_PREGENERATE_ASM
  cargo:rustc-env=RING_CORE_PREFIX=ring_core_0_17_8_
  OPT_LEVEL = Some(0)
  TARGET = Some(aarch64-unknown-linux-gnu)
  OUT_DIR = Some(/Users/bas/cross/target/aarch64-unknown-linux-gnu/debug/build/ring-be03176270e6aeb4/out)
  HOST = Some(aarch64-apple-darwin)
  cargo:rerun-if-env-changed=CC_aarch64-unknown-linux-gnu
  CC_aarch64-unknown-linux-gnu = None
  cargo:rerun-if-env-changed=CC_aarch64_unknown_linux_gnu
  CC_aarch64_unknown_linux_gnu = Some(aarch64-unknown-linux-gnu-gcc)
  cargo:rerun-if-env-changed=CC_KNOWN_WRAPPER_CUSTOM
  CC_KNOWN_WRAPPER_CUSTOM = None
  RUSTC_WRAPPER = None
  cargo:rerun-if-env-changed=CC_ENABLE_DEBUG_OUTPUT
  cargo:rerun-if-env-changed=CRATE_CC_NO_DEFAULTS
  CRATE_CC_NO_DEFAULTS = None
  DEBUG = Some(true)
  CARGO_CFG_TARGET_FEATURE = Some(neon)
  cargo:rerun-if-env-changed=CFLAGS_aarch64-unknown-linux-gnu
  CFLAGS_aarch64-unknown-linux-gnu = None
  cargo:rerun-if-env-changed=CFLAGS_aarch64_unknown_linux_gnu
  CFLAGS_aarch64_unknown_linux_gnu = None
  cargo:rerun-if-env-changed=TARGET_CFLAGS
  TARGET_CFLAGS = None
  cargo:rerun-if-env-changed=CFLAGS
  CFLAGS = Some(-iframework /nix/store/kgrj21piwxpifhh7xpnv6zcff471h76l-devenv-profile/Library/Frameworks)
  cargo:rerun-if-env-changed=CC_SHELL_ESCAPED_FLAGS
  CC_SHELL_ESCAPED_FLAGS = None
  cargo:warning=aarch64-unknown-linux-gnu-gcc: error: unrecognized command-line option '-iframework'

  --- stderr
```
