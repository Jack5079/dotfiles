{ inputs, pkgs, ... }: {
  imports = [
    ./snippets.nix # Language snippets for VSCode
  ];
  home.stateVersion = "23.05";
  home.username = "jack";
  home.homeDirectory = "/home/jack";
  nixpkgs.config.allowUnfree = true;
  gtk.theme = {
    package = pkgs.adw-gtk3;
    name = "Adw-gtk3-dark"; # or Adw-gtk3
  };
  home.file.".mozilla/firefox/default/chrome/firefox-gnome-theme".source = inputs.firefox-gnome-theme;
  programs = {
    nushell.enable = true;
    git = {
      enable = true;
      userName = "Jack W.";
      userEmail = "git@jack.cab";
      extraConfig = {
        core.editor = "code --wait";
        init.defaultBranch = "main";
        gpg.format = "ssh";
      };
    };
    vscode = {
      enable = true;
      package = pkgs.vscode.fhsWithPackages (ps: with ps; [
        nil # Nix LSP
        nixpkgs-fmt # Nix formatter
        nodePackages_latest.pnpm # Too lazy to package all my Node projects
      ]);
      # TODO: Manage extensions with nix
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
