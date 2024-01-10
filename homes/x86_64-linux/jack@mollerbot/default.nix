{ inputs, pkgs, config, ... }: {
  home.stateVersion = "23.05";
  imports = [
    inputs.nix-index-database.hmModules.nix-index
    { programs.nix-index-database.comma.enable = true; }
  ];
  home.packages = [
    pkgs.obsidian
    pkgs.songrec
    pkgs.helvum
    pkgs.nodePackages_latest.pnpm
    pkgs.android-studio
    pkgs.audacity
    pkgs.whois
    pkgs.gpu-screen-recorder-gtk
    pkgs.transmission_4-gtk
    pkgs.inkscape
    pkgs.git-absorb
    (pkgs.gimp-with-plugins.override {
      plugins = [(pkgs.gimpPlugins.resynthesizer.overrideAttrs {
        src = inputs.resynthesizer-scm;
        meta.broken = false;
      })];
    })
    pkgs.tor-browser
    pkgs.thunderbird
    pkgs.piper
    pkgs.fractal
    inputs.nix-software-center.packages.${pkgs.system}.nix-software-center
    (pkgs.prismlauncher.override {
      glfw = pkgs.glfw-wayland-minecraft;
    })
    pkgs.libsForQt5.kdenlive
    pkgs.me.vesktop-with-sane-icon
  ];
  programs = {
    nushell = {
      enable = true;
      shellAliases = {
        switch = "sudo nixos-rebuild switch --fast --print-build-logs";
        nx = "nix develop --command hx";
        nv = "nix develop --command code";
      };
      extraConfig = ''
        $env.config.show_banner = false;
        $env.config.shell_integration = true;
      '';
    };
    bun.enable = true;
    obs-studio.enable = true;
    vscode.enable = true;
    firefox.enable = true;
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
        theme = "github_dark";
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
  };
  services.syncthing = {
    enable = true;
    extraOptions = [
      "--config=${config.xdg.configHome}/syncthing"
      "--data=${config.home.homeDirectory}/Documents"
    ];
  };
}
