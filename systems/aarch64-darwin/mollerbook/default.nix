{ pkgs, lib, config, ... }: {
  system.stateVersion = 6;
  networking.hostName = "mollerbook";
  nix = {
    # https://nixos.org/manual/nix/stable/command-ref/conf-file.html
    settings = {
      experimental-features = [
        "flakes"
        "nix-command"
      ];
      log-lines = 10000000;
    };
    optimise.automatic = true;
    # https://github.com/Nyabinary/dotfiles/blob/4491af8ecc54fdd65ae4af7906080208682b15c9/hosts/default.nix#L30-L34
    gc = {
      automatic = true;
      options = "--delete-older-than 1d";
    };
    package = pkgs.lix;
    channel.enable = false;
  };
  system.activationScripts.diff = {
    supportsDryActivation = true;
    text = ''
      if [[ -e /run/current-system ]]; then
        ${lib.getExe pkgs.nvd} --nix-bin-dir=${config.nix.package}/bin diff /run/current-system "$systemConfig"
      fi
    '';
  };
}
