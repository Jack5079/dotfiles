{ inputs, pkgs, lib, config, ... }:
{
  home.stateVersion = "23.05";
  imports = [
    inputs.nix-index-database.hmModules.nix-index
    { programs.nix-index-database.comma.enable = true; programs.nix-index.enable = false; }
  ];
  home.packages = [ pkgs.nil pkgs.nixpkgs-fmt ];
  programs = {
    zsh.enable = true; # lol
    git = {
      enable = true;
      package = pkgs.git;
      userName = "Jack W.";
      userEmail = "git@jack.cab";
      signing = {
        format = "ssh";
        signByDefault = true;
      };
      extraConfig = {
        core.editor = "code --wait";
        init.defaultBranch = "main";
        user.signingkey = "~/.ssh/id_ed25519.pub";
      };
    };
    ghostty = {
      enable = true;
      package = null;
      settings = {
        # macos-titlebar-style = "tabs";
        # macos-icon = "custom-style";
        # macos-icon-frame = "plastic";
        # macos-icon-ghost-color = "#FF4539";
        # macos-icon-screen-color = "#00000F";
        command = lib.getExe pkgs.nushell;
      };
    };
    bun.enable = true;
    nushell = {
      enable = true;
      package = pkgs.nushell;
      shellAliases = {
        switch = "sudo -i darwin-rebuild switch --flake /Users/jack/dotfiles";
        nx = "nix develop --command hx";
        nv = "nix develop --command code";
        update = "nix flake update --commit-lock-file --flake ~/dotfiles";
        rs = "nix develop self#rust";
        whichnix = "nix build --no-link --print-out-paths";
      };
      extraConfig =
        ''
          $env.config.show_banner = false;
          use std/util "path add"
          path add "/usr/local/bin" # for vscode

          # for nix-darwin
          path add "/nix/var/nix/profiles/default/bin"
          path add "/run/current-system/sw/bin"

          # for home-manager
          path add ($env.HOME | path join ".nix-profile/bin")
          path add ($env.HOME | path join ".cargo/bin")
        '';
    };
  };
  services.home-manager.autoExpire.enable = true;
  services.home-manager.autoExpire.frequency = "daily";
  services.home-manager.autoExpire.timestamp = "-1 day";

}
