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
    home.file.".mozilla/firefox/default/chrome/firefox-gnome-theme".source = inputs.firefox-gnome-theme;
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
          # For Firefox GNOME theme:
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "svg.context-properties.content.enabled" = true;
          "browser.theme.dark-private-windows" = false;
          "gnomeTheme.hideSingleTab" = true;
          "gnomeTheme.hideWebrtcIndicator" = true;
        };
        userChrome = ''
          @import "firefox-gnome-theme/userChrome.css";
          html:not([inFullscreen="true"]) #sidebar-box {
            margin-top: -50px;
          }
          #sidebar-header:has(#sidebar-title[value="Sidebery"]) {
            display: none;
          }
          #sidebar-box {
            z-index: 500;
          }
        '';
        userContent = ''@import "firefox-gnome-theme/userContent.css";'';
      };
    };
  };
}
