{ inputs, pkgs, lib, config, ... }: {
  home.stateVersion = "23.05";
  imports = [
    inputs.nix-index-database.hmModules.nix-index
    { programs.nix-index-database.comma.enable = true; }
  ];
  home.packages = [
    pkgs.obsidian
    pkgs.songrec
    pkgs.helvum
    pkgs.eyedropper
    pkgs.ffmpeg_7-headless
    pkgs.android-studio
    pkgs.audacity
    pkgs.whois
    pkgs.gpu-screen-recorder-gtk
    pkgs.showtime
    # pkgs.transmission_4-gtk
    pkgs.git-absorb
    # GIMP intentionally removed: I use the beta version. Re-add when gimp 3.0 is released.
    pkgs.inkscape
    pkgs.tor-browser
    pkgs.thunderbird
    pkgs.piper
    pkgs.prismlauncher
    pkgs.kdePackages.kdenlive
    pkgs.me.vesktop-with-sane-icon
    pkgs.nix-output-monitor
    pkgs.breeze-icons # for 24.02+ gear apps when i dont have plasma
    pkgs.superTuxKart
  ];
  programs = {
    nushell = {
      enable = true;
      package = pkgs.nushell;
      shellAliases = {
        switch = "sudo nixos-rebuild switch --fast --print-build-logs";
        nx = "nix develop --command hx";
        nv = "nix develop --command code";
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

  # https://github.com/nix-community/home-manager/issues/4672
  systemd.user.services.expire-hm-profiles = {
    Unit.Description = "Clean up HM user profiles.";

    Service = {
      Type = "oneshot";
      ExecStart = lib.getExe (pkgs.writeShellApplication {
        name = "expire-hm-profiles-start-script";
        text = ''
          ${lib.getExe config.nix.package} profile wipe-history \
            --profile "${config.xdg.stateHome}/nix/profiles/home-manager" \
            --older-than '7d'
        '';
      });
    };
  };
  systemd.user.timers.expire-hm-profiles = {
    Unit.Description = "Clean up HM user profiles.";

    Timer = {
      OnCalendar = "weekly";
      Persistent = true;
    };

    Install.WantedBy = [ "timers.target" ];
  };
}
