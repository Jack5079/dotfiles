{ inputs, pkgs, system, ... }: {
  home.stateVersion = "23.05";
  home.packages = [
    pkgs.obsidian
    pkgs.songrec
    pkgs.helvum
    pkgs.nodePackages_latest.pnpm
    pkgs.arrpc
    pkgs.android-studio
    pkgs.tenacity
    pkgs.whois
    pkgs.fragments
    pkgs.git-absorb
    pkgs.gimp
    pkgs.element-desktop
    pkgs.obs-studio
    pkgs.piper
    inputs.nix-software-center.packages.${system}.nix-software-center
    pkgs.me.skylight-wallpaper
  ];
  programs = {
    nushell.enable = true;
    bun.enable = true;
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
  };
}
