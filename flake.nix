{
  description = "mollerbot";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox = {
      url = "github:nix-community/flake-firefox-nightly";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # https://github.com/NixOS/nixpkgs/pull/378543
    glfw-fork = {
      url = "github:Piecuuu/nixpkgs/glfw-minecraft-fix";
    };
    # LAZY TREES LAZY TREES LAZY TREES
    determinate = {
      url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    };
  };

  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      channels-config.allowUnfree = true;
      namespace = "me";
      package-namespace = "me";
      snowfall.namespace = "me";
      src = builtins.path { path = ./.; name = "dotfiles"; };
    };
}
