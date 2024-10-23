{ pkgs, lib, config, inputs, ... }:

{
  # https://devenv.sh/packages/
  packages = lib.optionals pkgs.stdenv.isDarwin (with pkgs.darwin.apple_sdk; [
    frameworks.Cocoa
  ]);

  languages = {
    rust = {
      enable = true;
      channel = "nightly";
      targets = ["aarch64-unknown-linux-gnu"];
      components = [ "rustc" "cargo" "clippy" "rustfmt" "rust-analyzer" ];
    };
  };
}
