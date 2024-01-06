{ pkgs }:
pkgs.mkShell {
  packages = [
    pkgs.rustc
    pkgs.cargo
    pkgs.cargo-watch
    pkgs.rust-analyzer
    pkgs.rustfmt
    pkgs.clippy
  ];

  RUST_BACKTRACE = "1";
  RUST_SRC_PATH = pkgs.rustPlatform.rustLibSrc;
}
