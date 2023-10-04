{ config, pkgs, inputs, lib, ... }:
{
  imports =
    [
      ./hardware.nix
      ./locale.nix
      ./desktop.nix
      ./network.nix
      ./phone.nix
    ];

  networking.hostName = "mollerbot";
  services.udev.packages = [
    pkgs.android-udev-rules
  ];
  # Configuring Nix itself
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      use-xdg-base-directories = false; # Some bug makes $PATH not update to the new directories so for now I'm disabling this
      auto-optimise-store = true;
      log-lines = 10000000;
    };
    registry.nixpkgs.flake = inputs.nixpkgs; # https://github.com/NixOS/nix/pull/6530, "incompatible changes"
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jack = {
    isNormalUser = true;
    description = "Jack W.";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "adbusers" ];
    shell = pkgs.nushell;
  };
  environment.shells = with pkgs; [ nushell ]; # Else PolicyKit breaks
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.supportedFilesystems = [ "ntfs" ]; # When I need to access my Windows partition

  # Plymouth, how wasn't this enabled by default?
  # boot.plymouth.enable = true; # Because it boots faster than fucking light
  # TODO: Etcetera-branded Plymouth theme

  services.printing.enable = true; # Enable CUPS to print documents.

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };


  fonts = {
    packages = [ pkgs.inter pkgs.iosevka pkgs.noto-fonts-cjk-sans ]; # TODO: Try out customizing Iosevka to find the most readable, then hardcode that
    fontDir.enable = true;
    fontconfig.defaultFonts = {
      sansSerif = [ "Inter" "Inter Regular" "Cantarell" "DejaVu Sans" ];
      monospace = [ "Iosevka" "DejaVu Sans Mono" ];
    };
  };

  # Custom fonts in Flatpak applications <https://github.com/NixOS/nixpkgs/issues/119433#issuecomment-1326957279>
  system.fsPackages = [ pkgs.bindfs ];
  fileSystems =
    let
      mkRoSymBind = path: {
        device = path;
        fsType = "fuse.bindfs";
        options = [ "ro" "resolve-symlinks" "x-gvfs-hide" ];
      };
      aggregatedFonts = pkgs.buildEnv {
        name = "system-fonts";
        paths = config.fonts.packages;
        pathsToLink = [ "/share/fonts" ];
      };
    in
    {
      # Create an FHS mount to support flatpak host icons/fonts
      "/usr/share/icons" = mkRoSymBind (config.system.path + "/share/icons");
      "/usr/share/fonts" = mkRoSymBind (aggregatedFonts + "/share/fonts");
    };

  # https://xeiaso.net/blog/paranoid-nixos-2021-07-18
  security.sudo.execWheelOnly = true;
  services.flatpak.enable = true;

  environment.systemPackages = [
    pkgs.me.skylight-wallpaper # TODO: Get working inside home-manager
  ];
  programs.steam.enable = true;
  environment.sessionVariables = {
    # EDITOR = lib.getExe pkgs.helix; # Might change this to `code --wait` later
    NIXOS_OZONE_WL = "1"; # https://gitlab.freedesktop.org/xorg/xserver/-/issues/1317 my hatred for X11 grows
  };

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
