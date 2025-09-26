{ inputs, pkgs, lib, config, ... }: {
  home.stateVersion = "23.05";
  imports = [
    inputs.nix-index-database.hmModules.nix-index
    { programs.nix-index-database.comma.enable = true; programs.nix-index.enable = false; }
  ];
  home.packages = [
    pkgs.obsidian
    pkgs.songrec
    pkgs.helvum
    pkgs.eyedropper
    pkgs.ffmpeg_7-headless
    pkgs.android-studio
    pkgs.audacity
    pkgs.rdap
    pkgs.gpu-screen-recorder-gtk
    pkgs.showtime
    # pkgs.transmission_4-gtk
    pkgs.git-absorb
    # GIMP intentionally removed: I use the beta version. Re-add when gimp 3.0 is released.
    pkgs.inkscape
    pkgs.tor-browser
    pkgs.thunderbird
    pkgs.piper
    (pkgs.prismlauncher.override {
      glfw3-minecraft = inputs.glfw-fork.legacyPackages.${pkgs.system}.glfw3-minecraft;
    })
    pkgs.kdePackages.kdenlive
    pkgs.me.vesktop-with-sane-icon
    pkgs.nix-output-monitor
    pkgs.superTuxKart
  ];
  programs = {
    ghostty = {
      enable = true;
      settings = {
        theme = "dark:Adwaita Dark,light:Adwaita";
        font-size = 10;
      };
    };
    nushell = {
      enable = true;
      package = pkgs.nushell;
      shellAliases = {
        switch = "sudo nixos-rebuild switch --fast --print-build-logs";
        nx = "nix develop --command hx";
        nv = "nix develop --command code";
        update = "nix flake update --commit-lock-file --flake ~/nix";
        rs = "nix develop self#rust";
      };
      extraConfig = "$env.config.show_banner = false;";
    };
    bun.enable = true;
    obs-studio.enable = true;
    vscode.enable = true;
    firefox.enable = true;
    git = {
      enable = true;
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
    helix = {
      enable = true;
      defaultEditor = true;
      ignores = [
        "!.gitignore"
        "!.prettierrc"
        "!.markdownlint.json"
        "!.gitattributes"
        "!.github/"
        "!.vscode/"
        #        "~/.vscode/"
        #        "~/go/"
        "node_modules/"

      ];
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
          end-of-line-diagnostics = "hint";
          inline-diagnostics = {
            cursor-line = "error";
            other-lines = "error";
          };
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

  services.home-manager.autoExpire.enable = true;
  services.home-manager.autoExpire.frequency = "weekly";
}
