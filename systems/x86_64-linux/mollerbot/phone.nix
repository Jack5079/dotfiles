{ config, pkgs, lib, ... }: {
  programs.kdeconnect = {
    enable = true;
    package = lib.mkIf config.services.desktopManager.gnome.enable pkgs.gnomeExtensions.gsconnect;
  };
}
