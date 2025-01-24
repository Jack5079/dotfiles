{ pkgs, config, ... }: {
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager = {
      gnome.enable = true;
    };
    excludePackages = [ pkgs.xterm ];
  };
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour # I've used GNOME before
    gnome-photos
    simple-scan
    seahorse
    geary
    gnome-connections
    snapshot # I do not have a webcam
    epiphany # Sometimes I uncomment this to test WebKit
    totem # Broken
    gnome-maps # I have a desktop
    gnome-music # I use Gapless instead
    gnome-contacts # Don't think I've ever used this
  ];
  # Sharing tab of GNOME; I use none of it and it could probably be a security risk
  services.gnome.gnome-remote-desktop.enable = false; # I don't use it, and it pulls in freerdp (725 MB)
  services.gnome.rygel.enable = false; # "Rygel UPnP Mediaserver", 897.7 MiB
  services.gnome.gnome-user-share.enable = false;

  # Casting
  services.dleyna-renderer.enable = false;
  services.dleyna-server.enable = false;

  services.gnome.gnome-initial-setup.enable = false; # home-manager sets up my desktop

  environment.sessionVariables.NIXOS_OZONE_WL = "1"; # https://gitlab.freedesktop.org/xorg/xserver/-/issues/1317
  environment.sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  fonts = {
    packages = [ pkgs.inter pkgs.noto-fonts-cjk-sans pkgs.source-sans-pro pkgs.commit-mono ];
    fontDir.enable = true;
    fontconfig.defaultFonts = {
      sansSerif = [ "Inter Variable" "Inter Variable Regular" "Inter" "Inter Regular" "Cantarell" "DejaVu Sans" "Noto Color Emoji" ];
      monospace = [ "Commit Mono" "DejaVu Sans Mono" ];
      emoji = [ "Noto Color Emoji" ];
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
}
