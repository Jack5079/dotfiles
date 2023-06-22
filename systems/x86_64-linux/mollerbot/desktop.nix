{ pkgs, ... }: {
  # xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ]; # https://github.com/NixOS/nixpkgs/issues/155291#issuecomment-1166199585
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.desktopManager.plasma5.enable = false;

  # Fuck the defaults
  services.xserver.excludePackages = [ pkgs.xterm ];
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour # I've used GNOME before
    gnome-photos
    gnome.simple-scan
    gnome.gnome-maps # I have a desktop
    gnome.seahorse
    gnome.geary
    gnome.cheese # I do not have a webcam
    epiphany # Sometimes I uncomment this to test WebKit
    gnome.gnome-music # I use Amberol instead
  ];

  environment.systemPackages = with pkgs.gnomeExtensions; [
    tray-icons-reloaded
    hot-edge
    just-perfection
    paperwm
    # GSConnect was installed in ./phone.nix when I set programs.kdeconnect.package
  ];
}
