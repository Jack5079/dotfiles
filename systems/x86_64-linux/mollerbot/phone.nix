{ config, pkgs, lib, ... }: {
  programs.kdeconnect = {
    enable = true;
    package = lib.mkIf config.services.xserver.desktopManager.gnome.enable pkgs.gnomeExtensions.gsconnect;
  };
}
