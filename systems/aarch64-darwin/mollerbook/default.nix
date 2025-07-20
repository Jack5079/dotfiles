{ pkgs, lib, inputs, config, ... }: {
  system.stateVersion = 6;
  nix = {
    # https://nixos.org/manual/nix/stable/command-ref/conf-file.html
    settings = {
      experimental-features = [
        "flakes"
        "nix-command"
      ];
      use-xdg-base-directories = false; # Some bug makes $PATH not update to the new directories so for now I'm disabling this
      # lazy-trees = true; # LAZY TREES LAZY TREES LAZY TREES
      log-lines = 10000000;
    };
    optimise.automatic = true;
    # https://github.com/Nyabinary/dotfiles/blob/4491af8ecc54fdd65ae4af7906080208682b15c9/hosts/default.nix#L30-L34
    gc = {
      automatic = true;
      options = "--delete-older-than 1d";
    };
    channel.enable = false;
    # package = pkgs.nixVersions.latest; # LAZY TREES LAZY TREES LAZY TREES
    registry.nixpkgs.flake = inputs.nixpkgs;
    nixPath = [ "nixpkgs=flake:nixpkgs" ];
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