{ vscode, ... }: vscode.fhsWithPackages (ps: with ps; [
  nil # Nix LSP
  nixpkgs-fmt # Nix formatter
  nodePackages_latest.pnpm # Too lazy to package all my Node projects
])
# TODO: https://github.com/nix-community/nix-vscode-extensions
