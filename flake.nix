{
  description = "mollerbot";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-software-center = {
      url = "github:snowfallorg/nix-software-center";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "home-manager";
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
    firefox-gnome-theme = { url = "github:rafaelmardojai/firefox-gnome-theme/nightly"; flake = false; };
    resynthesizer-scm = { url = "github:itr-tert/gimp-resynthesizer-scm"; flake = false; };
    vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      channels-config.allowUnfree = true;
      namespace = "me";
      package-namespace = "me";
      snowfall.namespace = "me";
      src = ./.;
    };
}
