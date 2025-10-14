{ inputs, pkgs, config, lib, ... }: {
  config = lib.mkIf config.programs.vscode.enable {
    # LSP, see https://github.com/microsoft/vscode/issues/188612 for when I can stop installing these globally
    home.packages = with pkgs;
      [
        nil
        nixpkgs-fmt
      ];

    programs.vscode = {
      # https://github.com/nix-community/home-manager/issues/4394#issuecomment-1712909231
      mutableExtensionsDir = false;
      profiles.default = {
        languageSnippets = import ./snippets.nix;
        extensions = pkgs.callPackage ./extensions.nix {
          # https://github.com/nix-community/nix-vscode-extensions/issues/99
          extensions = (inputs.vscode-extensions.overlays.default pkgs pkgs).vscode-marketplace // (inputs.vscode-extensions.overlays.default pkgs pkgs).vscode-marketplace-release // pkgs.vscode-extensions;
        };
      };
    };
  };
}
