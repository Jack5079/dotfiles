{ pkgs, inputs, lib, ... }:
{
  imports =
    [
      ./hardware.nix
      ./locale.nix
      ./desktop.nix
      ./network.nix
      ./phone.nix
    ];
  virtualisation.vmVariant =
    {
      # following configuration is added only when building VM with build-vm
      virtualisation = {
        memorySize = 8192; # Use 2048MiB memory.
        cores = 12;
      };
    };
  security.hardened = true;
  networking.hostName = "mollerbot";
  services.udev.packages = [
    pkgs.android-udev-rules
  ];
  home-manager.useUserPackages = true; # "This is necessary if, for example, you wish to use `nixos-rebuild build-vm`" ―https://nix-community.github.io/home-manager/#:~:text=use%20nixos-rebuild-,build-vm,-.%20This%20option%20may
  home-manager.useGlobalPkgs = true;
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
    };
    # https://github.com/Nyabinary/dotfiles/blob/4491af8ecc54fdd65ae4af7906080208682b15c9/hosts/default.nix#L30-L34
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    registry.nixpkgs.flake = inputs.nixpkgs; # https://github.com/NixOS/nix/pull/6530, "incompatible changes"
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jack = {
    isNormalUser = true;
    description = "Jack W.";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "adbusers" ];
    initialHashedPassword = "$y$j9T$08sb4D2lguIDpdoEKxY450$EpQpDMvff04dmk8FqPYMQIu2pqymSGjqDDkqslKtK9D";
    shell = pkgs.nushell;
  };
  environment.shells = with pkgs; [ nushell ]; # Else PolicyKit breaks
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.supportedFilesystems = [ "ntfs" ]; # When I need to access my Windows partition
  boot.initrd.systemd.enable = true;

  services.printing.enable = true; # Enable CUPS to print documents.
  services.flatpak.enable = true;
  programs.steam.enable = true;
  programs.virt-manager.enable = true;

  # https://github.com/luishfonseca/dotfiles/blob/main/modules/upgrade-diff.nix
  system.activationScripts.diff = {
    supportsDryActivation = true;
    text = ''
      ${lib.getExe pkgs.nvd} --nix-bin-dir=${pkgs.nix}/bin diff /run/current-system "$systemConfig"
    '';
  };
  services.gpm.enable = true;
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
