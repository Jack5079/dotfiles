{ pkgs, lib, config, ... }:
{
  imports =
    [
      ./hardware.nix
      ./locale.nix
      ./desktop.nix
      ./network.nix
      ./phone.nix
      ./nix.nix
      # ./perlless.nix # I will regret this
    ];
  # for build-vm
  virtualisation.vmVariant = {
    virtualisation.memorySize = 8192;
    virtualisation.cores = 12;
  };

  networking.hostName = "mollerbot";
  services.udev.packages = [
    pkgs.android-udev-rules
  ];
  home-manager.useUserPackages = true; # "This is necessary if, for example, you wish to use `nixos-rebuild build-vm`" ―https://nix-community.github.io/home-manager/#:~:text=use%20nixos-rebuild-,build-vm,-.%20This%20option%20may
  home-manager.useGlobalPkgs = true; # Now default in Snowfall https://github.com/snowfallorg/lib/commit/6f2e2819df4770b7ab81827e3cb27b738c7c7721 but keeping this here to be explicit
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jack = {
    isNormalUser = true;
    description = "Jack W.";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "adbusers" "kvm" ];
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

  services.printing.enable = false; # Enable CUPS to print documents.

  boot.enableContainers = false;
  # The notion of "online" is a broken concept
  # https://github.com/systemd/systemd/blob/e1b45a756f71deac8c1aa9a008bd0dab47f64777/NEWS#L13
  systemd.services.NetworkManager-wait-online.enable = false;
  systemd.network.wait-online.enable = false;

  services.flatpak.enable = true;
  programs.steam.enable = true;
   programs.virt-manager.enable = true; # I think this is causing issues

  # https://github.com/nix-community/srvos/blob/main/nixos/common/upgrade-diff.nix
  system.activationScripts.diff = {
    supportsDryActivation = true;
    text = ''
      if [[ -e /run/current-system ]]; then
        ${lib.getExe pkgs.lix-diff} --lix-bin=${config.nix.package}/bin diff /run/current-system "$systemConfig"
      fi
    '';
  };
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
