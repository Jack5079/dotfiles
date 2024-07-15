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
    snapshot # I do not have a webcam
    epiphany # Sometimes I uncomment this to test WebKit
    gnome.gnome-maps # I have a desktop
    gnome.gnome-music # I use G4Music instead
    gnome.gnome-contacts # Don't think I've ever used this
  ];
  services.gnome.gnome-remote-desktop.enable = false; # I don't use it, and it pulls in freerdp (725 MB)
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
