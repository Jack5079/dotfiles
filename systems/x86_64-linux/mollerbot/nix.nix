{ inputs, pkgs, ... }: {
  imports = [
#  inputs.determinate.nixosModules.default # LAZY TREES LAZY TREES LAZY TREES
  
  ];
  nix = {
    # https://nixos.org/manual/nix/stable/command-ref/conf-file.html
    settings = {
      experimental-features = [
        "flakes"
        "nix-command"
      ];
      use-xdg-base-directories = false; # Some bug makes $PATH not update to the new directories so for now I'm disabling this
      auto-optimise-store = true;
#      lazy-trees = true; # LAZY TREES LAZY TREES LAZY TREES
      log-lines = 10000000;
    };
    # https://github.com/Nyabinary/dotfiles/blob/4491af8ecc54fdd65ae4af7906080208682b15c9/hosts/default.nix#L30-L34
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    channel.enable = false;
    package = pkgs.nixVersions.latest; # LAZY TREES LAZY TREES LAZY TREES
    registry.nixpkgs.flake = inputs.nixpkgs;
    nixPath = [ "nixpkgs=flake:nixpkgs" ];
  };
}
