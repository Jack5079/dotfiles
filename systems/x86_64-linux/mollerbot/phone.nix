{ config, pkgs, lib, ... }: {
    services.syncthing = {
    enable = true;
    user = "jack";
    dataDir = "/home/jack/Documents"; # Default folder for new synced folders
    configDir = "/home/jack/.config/syncthing"; # Folder for Syncthing's settings and keys
  };
  programs.firefox.nativeMessagingHosts.gsconnect = config.services.xserver.desktopManager.gnome.enable;
  programs.kdeconnect = {
    enable = true;
    package = lib.mkIf (config.services.xserver.desktopManager.gnome.enable) pkgs.gnomeExtensions.gsconnect;
  };
}
