{ inputs, pkgs, lib, config, ... }: let
  expireScript = pkgs.writeShellApplication {
    name = "expire-hm-profiles-script";
    text = ''
      ${lib.getExe config.nix.package} profile wipe-history \
        --profile "${config.xdg.stateHome}/nix/profiles/home-manager" \
        --older-than '7d'
    '';
  };
in {
  home.stateVersion = "23.05";
  imports = [
    inputs.nix-index-database.hmModules.nix-index
    { programs.nix-index-database.comma.enable = true; programs.nix-index.enable = false; }
  ];
  home.packages = [pkgs.nil pkgs.nixpkgs-fmt];
  programs.ghostty = {
    enable = true;
    package = null;
    settings = {
      command = lib.getExe pkgs.nushell;
    };
  };
  programs.nushell = {
    enable = true;
    package = pkgs.nushell;
    shellAliases = {
      switch = "sudo -i darwin-rebuild switch --flake /Users/jack/dotfiles";
      nx = "nix develop --command hx";
      nv = "nix develop --command code";
      update = "nix flake update --commit-lock-file --flake ~/dotfiles";
      rs = "nix develop self#rust";
    };
    extraConfig =
    ''
    $env.config.show_banner = false;
    use std/util "path add"
    path add "/nix/var/nix/profiles/default/bin"
    path add "/run/current-system/sw/bin"
    path add ($env.HOME | path join ".nix-profile/bin")
    '';
  };
launchd.agents.expire-hm-profiles = {
    enable = true;
    config = {
      ProgramArguments = [ (lib.getExe expireScript) ];
      StartCalendarInterval = {
        Hour = 12;
        Minute = 0;
      };
      StandardErrorPath = "${config.xdg.dataHome}/expire-hm-profiles.err.log";
      StandardOutPath = "${config.xdg.dataHome}/expire-hm-profiles.out.log";
    };
  };
}