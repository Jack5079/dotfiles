{ inputs, pkgs, system, ... }: {
  imports = [
    ./vscode.nix
    ./dconf.nix
  ];
  home.stateVersion = "23.05";
  home.packages = [
    pkgs.obsidian
    pkgs.nil # Workaround to get LSP for Nix until https://github.com/microsoft/vscode/issues/147911 so I can just set the path here
    pkgs.nixpkgs-fmt # Ditto
    pkgs.songrec
    pkgs.helvum
    pkgs.nodePackages_latest.pnpm
    pkgs.arrpc
    pkgs.android-studio
    pkgs.tenacity
    pkgs.whois
    pkgs.fragments
    pkgs.virt-manager
    pkgs.git-absorb
    pkgs.adw-gtk3
    pkgs.gnome.gnome-tweaks
    pkgs.gimp
    pkgs.element-desktop
    pkgs.obs-studio
    pkgs.piper
    inputs.nix-software-center.packages.${system}.nix-software-center
    pkgs.me.skylight-wallpaper
    # GSConnect was installed in systems/x84_64-linux/mollerbot/phone.nix when I set programs.kdeconnect.package
    pkgs.gnomeExtensions.tray-icons-reloaded
    pkgs.gnomeExtensions.hot-edge
    pkgs.gnomeExtensions.just-perfection
    pkgs.gnomeExtensions.paperwm
    pkgs.gnomeExtensions.overview-background
    pkgs.gnomeExtensions.wayland-or-x11
  ];

  home.file.".mozilla/firefox/default/chrome/firefox-gnome-theme".source = inputs.firefox-gnome-theme;
  programs = {
    nushell.enable = true;
    bun.enable = true;
    git = {
      enable = true;
      userName = "Jack W.";
      userEmail = "git@jack.cab";
      extraConfig = {
        core.editor = "code --wait";
        init.defaultBranch = "main";
        commit.gpgsign = true;
        user.signingkey = "~/.ssh/id_ed25519.pub";
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
