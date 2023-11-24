{ inputs, pkgs, config, lib, ... }: {
  config = lib.mkIf config.programs.vscode.enable {
    # LSP, see https://github.com/microsoft/vscode/issues/188612 for when I can stop installing these globally
    home.packages = with pkgs; [
      nil
      nixpkgs-fmt
    ];

    programs.vscode = {
      # https://github.com/nix-community/home-manager/issues/4394#issuecomment-1712909231
      mutableExtensionsDir = false;
      languageSnippets = import ./snippets.nix;
      extensions = import ./extensions.nix inputs.vscode-extensions.extensions.${pkgs.system}.vscode-marketplace;
    };
  };
}
