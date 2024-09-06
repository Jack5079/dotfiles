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
    totem # Broken
    gnome-maps # I have a desktop
    gnome-music # I use Gapless instead
    gnome-contacts # Don't think I've ever used this
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
      emoji = [ "Noto Color Emoji" ]; # I love NixOS defaults 😀
    };
  };
}
