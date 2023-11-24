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

  # https://github.com/nix-community/srvos/blob/main/nixos/common/upgrade-diff.nix
  system.activationScripts.diff = {
    supportsDryActivation = true;
    text = ''
      if [[ -e /run/current-system ]]; then
        ${lib.getExe pkgs.nvd} --nix-bin-dir=${config.nix.package}/bin diff /run/current-system "$systemConfig"
      fi
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
