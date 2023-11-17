{ inputs, ... }: {
  nix = {
    # https://nixos.org/manual/nix/stable/command-ref/conf-file.html
    settings = {
      # How to update this array later: Go to https://nixos.org/manual/nix/stable/contributing/experimental-features#currently-available-experimental-features
      # and run `copy(JSON.stringify($$("#currently-available-experimental-features ~ h2").map(h2 => h2.textContent), null, 2).replaceAll(",", ""))`
      experimental-features = [
        "auto-allocate-uids"
        "ca-derivations"
        "cgroups"
        "daemon-trust-override"
        "dynamic-derivations"
        "fetch-closure"
        "flakes"
        "impure-derivations"
        "nix-command"
        "no-url-literals"
        "parse-toml-timestamps"
        "read-only-local-store"
        "recursive-nix"
        "repl-flake"
      ];
      use-xdg-base-directories = false; # Some bug makes $PATH not update to the new directories so for now I'm disabling this
      auto-optimise-store = true;
      log-lines = 10000000;
      substituters = [
        "https://nix-community.cachix.org"
        "https://helix.cachix.org"
        "https://hyprland.cachix.org"
        "https://cache.garnix.io"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];
    };
    # https://github.com/Nyabinary/dotfiles/blob/4491af8ecc54fdd65ae4af7906080208682b15c9/hosts/default.nix#L30-L34
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    registry.nixpkgs.flake = inputs.nixpkgs;
    nixPath = [ "nixpkgs=flake:nixpkgs" ];
  };
}
