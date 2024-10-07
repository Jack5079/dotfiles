{ inputs
, config
, osConfig ? {
    services.xserver.desktopManager = {
      plasma5.enable = false;
      gnome.enable = false;
    };
  }
, lib
, pkgs
, ...
}: {
  config = lib.mkIf config.programs.firefox.enable {
    programs.firefox = {
      package = inputs.firefox.packages.${pkgs.system}.firefox-nightly-bin.override {
        nativeMessagingHosts = lib.optionals osConfig.services.xserver.desktopManager.gnome.enable [
          pkgs.gnomeExtensions.gsconnect
          pkgs.gnome-browser-connector
        ] ++ lib.optionals osConfig.services.xserver.desktopManager.plasma5.enable [
          pkgs.plasma5Packages.plasma-browser-integration
        ];
      };
      profiles.default = {
        isDefault = true;
        name = "default";
        id = 0;
        settings = {
          "svg.context-properties.content.enabled" = true;
          "browser.theme.dark-private-windows" = false;
          "gnomeTheme.hideSingleTab" = true;
          "gnomeTheme.hideWebrtcIndicator" = true;
          "sidebar.revamp" = true; # No more header 🎉
        };
      };
    };
  };
}
