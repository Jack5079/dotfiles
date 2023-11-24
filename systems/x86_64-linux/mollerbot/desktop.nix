{ pkgs, config, inputs, ... }: {
  # xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ]; # https://github.com/NixOS/nixpkgs/issues/155291#issuecomment-1166199585
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager = {
      gnome.enable = true;
      plasma5.enable = false;
    };
    excludePackages = [ pkgs.xterm ];
  };
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour # I've used GNOME before
    gnome-photos
    gnome.simple-scan
    gnome.gnome-maps # I have a desktop
    gnome.seahorse
    gnome.geary
    snapshot # I do not have a webcam
    epiphany # Sometimes I uncomment this to test WebKit
    gnome.gnome-music # I use Amberol instead
  ];
  environment.sessionVariables.NIXOS_OZONE_WL = "1"; # https://gitlab.freedesktop.org/xorg/xserver/-/issues/1317
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
    packages = [ inputs.nixpkgs-with-inter-v4.legacyPackages.${pkgs.system}.inter pkgs.noto-fonts-cjk-sans pkgs.source-sans-pro pkgs.go-font pkgs.monaspace ];
    fontDir.enable = true;
    fontconfig.defaultFonts = {
      sansSerif = [ "Inter Variable" "Inter Variable Regular" "Inter" "Inter Regular" "Cantarell" "DejaVu Sans" ];
      monospace = [ "Monaspace Neon Var" "Monaspace Neon Regular" "DejaVu Sans Mono" ];
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
