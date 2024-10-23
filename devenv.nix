{ pkgs, lib, config, inputs, ... }:

{
  # https://devenv.sh/basics/
  # env.OPENSSL_DIR = pkgs.pkgsCross.aarch64-unknown-linux-gnu.gcc;
  # env.PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";

  # https://devenv.sh/packages/
  packages = [
    pkgs.hey pkgs.google-cloud-sdk pkgs.docker pkgs.black pkgs.protobuf pkgs.openssl.dev pkgs.pkg-config
  ] ++
  (with pkgs.python3Packages; [
    alembic pg8000 httpx segno argon2-cffi
  ]) ++
  lib.optionals pkgs.stdenv.isDarwin (with pkgs.darwin.apple_sdk; [
    frameworks.Security frameworks.Cocoa
  ]);

  # https://devenv.sh/languages/
  # languages.rust.enable = true;

  # https://devenv.sh/processes/
  # processes.cargo-watch.exec = "cargo-watch";

  # https://devenv.sh/services/
  # services.postgres.enable = true;

  # https://devenv.sh/scripts/
  scripts.hello.exec = ''
    echo hello from $GREET
  '';

  enterShell = ''
    hello
    git --version
  '';

  # https://devenv.sh/tasks/
  # tasks = {
  #   "myproj:setup".exec = "mytool build";
  #   "devenv:enterShell".after = [ "myproj:setup" ];
  # };
    languages = {
    rust = {
      enable = true;
      channel = "nightly";
      targets = ["aarch64-unknown-linux-gnu"];
      components = [ "rustc" "cargo" "clippy" "rustfmt" "rust-analyzer" ];
    };

    python = {
      enable = true;
      poetry = {
        enable = true;
      };
    };
  };

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
  '';

  # https://devenv.sh/pre-commit-hooks/
  # pre-commit.hooks.shellcheck.enable = true;

  # See full reference at https://devenv.sh/reference/options/
}
