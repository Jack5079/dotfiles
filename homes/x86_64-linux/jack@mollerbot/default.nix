{ inputs, pkgs, system, ... }: {
  imports = [
    ./vscode.nix
    # ./skylight
  ];
  home.stateVersion = "23.05";
  home.username = "jack";
  home.homeDirectory = "/home/jack";
  nixpkgs.config.allowUnfree = true;
  # gtk.theme = {
  #   package = pkgs.adw-gtk3;
  #   name = "Adw-gtk3-dark"; # or Adw-gtk3
  # };
  home.packages = [
    pkgs.obsidian
    pkgs.nil # Workaround to get LSP for Nix until https://github.com/microsoft/vscode/issues/147911 so I can just set the path here
    pkgs.nixpkgs-fmt # Ditto
    pkgs.songrec
    pkgs.helvum
    pkgs.nodePackages_latest.pnpm
    inputs.nix-software-center.packages.${system}.nix-software-center
    # https://github.com/NixOS/nixpkgs/pull/254046, not yet merged
    inputs.nixpkgs-staging.legacyPackages.${system}.bun
  ];

  home.file.".mozilla/firefox/default/chrome/firefox-gnome-theme".source = inputs.firefox-gnome-theme;
  programs = {
    nushell.enable = true;
    git = {
      enable = true;
      userName = "Jack W.";
      userEmail = "git@jack.cab";
      # https://bun.sh/docs/install/lockfile#how-do-i-git-diff-bun-s-lockfile
      attributes = [ "*.lockb diff=lockb" ];
      extraConfig = {
        diff.lockb = {
          textconv = "bun";
          binary = true;
        };
        core.editor = "code --wait";
        init.defaultBranch = "main";
        gpg.format = "ssh";
      };
    };
    helix = {
      enable = true;
      defaultEditor = true;
      settings = {
        theme = "adwaita-dark";
        editor = {
          bufferline = "multiple";
          auto-save = true;
          gutters = [ "diagnostics" "line-numbers" "diff" ];
          cursorline = true;
          color-modes = true;
          indent-guides.render = true;
          lsp.display-messages = true;
        };
      };
    };
    firefox = {
      enable = true;
      package = pkgs.firefox.override {
        cfg = {
          enableGnomeExtensions = true;
        };
      };
      profiles.default = {
        isDefault = true;
        name = "default";
        id = 0;
        settings = {
          # For Firefox GNOME theme:
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "svg.context-properties.content.enabled" = true;
          "browser.theme.dark-private-windows" = false;
          "gnomeTheme.hideSingleTab" = true;
          "gnomeTheme.hideWebrtcIndicator" = true;
        };
        userChrome = ''@import "firefox-gnome-theme/userChrome.css";'';
        userContent = ''@import "firefox-gnome-theme/userContent.css";'';
      };
    };
  };
}
