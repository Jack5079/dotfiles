{ pkgs }:
pkgs.mkShell {
  packages = [
    pkgs.rustc
    pkgs.cargo
    pkgs.cargo-watch
    pkgs.cargo-generate
    pkgs.rust-analyzer
    pkgs.rustfmt
    pkgs.clippy
    pkgs.wasm-pack
  ];

  RUST_BACKTRACE = "1";
  RUST_SRC_PATH = pkgs.rustPlatform.rustLibSrc;
}
