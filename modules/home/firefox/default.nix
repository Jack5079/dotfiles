{ inputs, config, osConfig, lib, pkgs, ... }: {
  config = lib.mkIf config.programs.firefox.enable {
    home.file.".mozilla/firefox/default/chrome/firefox-gnome-theme".source = inputs.firefox-gnome-theme;
    programs.firefox = {
      package = inputs.firefox.packages.${pkgs.system}.firefox-nightly-bin.override {
        cfg = {
          enableGnomeExtensions = osConfig.services.xserver.desktopManager.gnome.enable;
          enablePlasmaBrowserIntegration = osConfig.services.xserver.desktopManager.plasma5.enable;
        };
        nativeMessagingHosts = [
          inputs.pipewire-screenaudio.packages.${pkgs.system}.default
        ] ++ lib.optional osConfig.services.xserver.desktopManager.gnome.enable pkgs.gnomeExtensions.gsconnect;
      };
      profiles.default = {
        isDefault = true;
        name = "default";
        id = 0;
        settings = {
          # For Firefox GNOME theme:
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "svg.context-properties.content.enabled" = true;
          "browser.theme.dark-private-windows" = false;
          "gnomeTheme.hideSingleTab" = true;
          "gnomeTheme.hideWebrtcIndicator" = true;
        };
        userChrome = ''@import "firefox-gnome-theme/userChrome.css";'';
        userContent = ''@import "firefox-gnome-theme/userContent.css";'';
      };
    };
  };
}
