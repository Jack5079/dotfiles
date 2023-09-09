{
  description = "mollerbot";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-staging.url = "nixpkgs/staging";
    snowfall-lib = {
      url = "github:snowfallorg/lib/dev";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-software-center = {
      url = "github:vlinkz/nix-software-center";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-gnome-theme = { url = "github:rafaelmardojai/firefox-gnome-theme"; flake = false; };
    vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      channels-config.allowUnfree = true;
      namespace = "me";
      package-namespace = "me";
      overlay-package-namespace = "me";
      src = ./.;
    };
}
