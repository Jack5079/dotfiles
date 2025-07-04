{ config, lib, modulesPath, pkgs, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];
  #  boot.kernelPackages = pkgs.linuxPackages_latest; # "the hardened patches frequently lag behind the upstream kernel." https://github.com/NixOS/nixpkgs/blob/f7edf57b886d3f0f52a224f993bce1d0cb740232/pkgs/top-level/aliases.nix#L497
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  #  boot.extraModulePackages = with config.boot.kernelPackages; [ xpadneo ]; # https://github.com/atar-axis/xpadneo/

  boot.kernelParams = [
    "split_lock_detect=off"
  ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/89b2dc1f-e231-4bcb-b67a-25f49a32ada6";
      fsType = "ext4";
    };

  fileSystems."/boot/efi" =
    {
      device = "/dev/disk/by-uuid/7C1F-0E6C";
      fsType = "vfat";
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp5s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp4s0.useDHCP = lib.mkDefault true;
  services.ratbagd.enable = true;
  # NVIDIA
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.open = false;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.production; # New NVIDIA drivers are awful

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
