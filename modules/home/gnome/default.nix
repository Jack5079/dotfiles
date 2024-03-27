{ lib, osConfig ? { services.xserver.desktopManager.gnome.enable = false; }, pkgs, ... }:

{
  config = lib.mkIf osConfig.services.xserver.desktopManager.gnome.enable {
    # GSConnect was installed in systems/x84_64-linux/mollerbot/phone.nix when I set programs.kdeconnect.package
    home.packages = with pkgs.gnomeExtensions; [
      appindicator
      hot-edge
      just-perfection
      paperwm
      overview-background
      wayland-or-x11
    ] ++ [
      pkgs.adw-gtk3
      pkgs.gnome.gnome-tweaks
      pkgs.me.skylight-wallpaper
    ];

    dconf.settings = {
      "org/gnome/GWeather4".temperature-unit = "fahrenheit";

      "org/gnome/desktop/wm/keybindings" = {
        switch-applications = [ ]; # @as
        switch-applications-backward = [ ]; # @as
        switch-windows = [ "<Alt>Tab" ];
        switch-windows-backward = [ "<Shift><Alt>Tab" ];
        toggle-fullscreen = [ "<Shift><Super>Return" ];
      };

      "org/gnome/shell/keybindings" = {
        screenshot-window = [ "<Super>Print" ];
        show-screenshot-ui = [ "Print" ];
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        control-center = [ "<Super>i" ];
        custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
        home = [ "<Super>e" ];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Control>Escape";
        command = "gnome-system-monitor";
        name = "open task man";
      };

      "org/gnome/shell/extensions/paperwm/keybindings" = {
        switch-left = [ "<Super>Left" "<Super>comma" ];
        switch-next = [ "<Super>d" "<Super>period" ];
        switch-previous = [ "<Super>a" ];
        toggle-scratch = [ "<Super>s" ];
      };

      "org/gnome/settings-daemon/plugins/power" = {
        power-button-action = "interactive";
        sleep-inactive-ac-type = "nothing";
      };

      "org/gnome/mutter" = {
        attach-modal-dialogs = true;
        dynamic-workspaces = true;
        edge-tiling = true;
        focus-change-on-pointer-rest = true;
        overlay-key = "Super_L";
        workspaces-only-on-primary = true;
        experimental-features = [ "scale-monitor-framebuffer" ];
      };

      "org/gnome/shell" = {
        disable-user-extensions = false;
        disabled-extensions = [
          "activate_gnome@isjerryxiao"
          "screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "lightshell@dikasp.gitlab"
          "paperwm@hedning:matrix.org"
        ];
        enabled-extensions = [
          "gsconnect@andyholmes.github.io"
          "appindicatorsupport@rgcjonas.gmail.com"
          "flypie@schneegans.github.com"
          "switch-x11-wayland@prasanthc41m.github.com"
          "light-style@gnome-shell-extensions.gcampax.github.com"
          "overviewbackground@github.com.orbitcorrection"
          "just-perfection-desktop@just-perfection"
          "hotedge@jonathan.jdoda.ca"
          "waylandorx11@injcristianrojas.github.com"
        ];
        favorite-apps = [
          "firefox-nightly.desktop"
          "code.desktop"
          "org.gnome.Console.desktop"
          "thunderbird.desktop"
          "obsidian.desktop"
          "torbrowser.desktop"
          "org.gnome.Nautilus.desktop"
          "vesktop.desktop"
          "org.gnome.Fractal.desktop"
          "gimp.desktop"
          "org.inkscape.Inkscape.desktop"
          "org.gnome.design.IconLibrary.desktop"
          "org.kde.kdenlive.desktop"
          "com.github.unrud.VideoDownloader.desktop"
          "com.obsproject.Studio.desktop"
          "org.blender.Blender.desktop"
          "steam.desktop"
          "org.prismlauncher.PrismLauncher.desktop"
          "dev.vlinkz.NixSoftwareCenter.desktop"
          "org.gnome.Software.desktop"
        ];
        welcome-dialog-last-shown-version = "1000000";
      };

      "org/gnome/shell/extensions/flypie" = {
        active-stack-child = "menu-editor-page";
        background-color = "rgba(0, 0, 0, 0.26)";
        center-auto-color-luminance = 0.8;
        center-auto-color-luminance-hover = 0.8;
        center-auto-color-opacity = 0.0;
        center-auto-color-opacity-hover = 0.0;
        center-auto-color-saturation = 0.75;
        center-auto-color-saturation-hover = 0.75;
        center-background-image = "assets/adwaita-dark.svg";
        center-background-image-hover = "assets/adwaita-dark.svg";
        center-color-mode = "fixed";
        center-color-mode-hover = "fixed";
        center-fixed-color = "rgba(255,255,255,0)";
        center-fixed-color-hover = "rgba(255,255,255,0)";
        center-icon-crop = 0.8;
        center-icon-crop-hover = 0.8;
        center-icon-opacity = 0.17;
        center-icon-opacity-hover = 1.0;
        center-icon-scale = 0.7;
        center-icon-scale-hover = 0.7;
        center-size = 110.0;
        center-size-hover = 90.0;
        child-auto-color-luminance = 0.7;
        child-auto-color-luminance-hover = 0.8802816901408451;
        child-auto-color-opacity = 1.0;
        child-auto-color-opacity-hover = 1.0;
        child-auto-color-saturation = 0.9;
        child-auto-color-saturation-hover = 1.0;
        child-background-image = "assets/adwaita-dark.svg";
        child-background-image-hover = "assets/adwaita-dark.svg";
        child-color-mode = "fixed";
        child-color-mode-hover = "fixed";
        child-draw-above = false;
        child-fixed-color = "rgba(255,255,255,0)";
        child-fixed-color-hover = "rgba(255,255,255,0)";
        child-icon-crop = 0.8;
        child-icon-crop-hover = 0.8;
        child-icon-opacity = 1.0;
        child-icon-opacity-hover = 1.0;
        child-icon-scale = 0.7;
        child-icon-scale-hover = 0.7;
        child-offset = 106.0;
        child-offset-hover = 113.0;
        child-size = 59.0;
        child-size-hover = 77.0;
        easing-duration = 0.25;
        easing-mode = "ease-out";
        font = "Open Sans Bold 11";
        grandchild-background-image = "assets/adwaita-dark.svg";
        grandchild-background-image-hover = "assets/adwaita-dark.svg";
        grandchild-color-mode = "fixed";
        grandchild-color-mode-hover = "fixed";
        grandchild-draw-above = false;
        grandchild-fixed-color = "rgba(189,184,178,0)";
        grandchild-fixed-color-hover = "rgba(189,184,178,0)";
        grandchild-offset = 25.0;
        grandchild-offset-hover = 31.0;
        grandchild-size = 17.0;
        grandchild-size-hover = 27.0;
        hover-mode = true;
        label-font = "Open Sans 8";
        achievement-notifications = false;
        menu-configuration = builtins.toJSON [{
          centered = false;
          children = [
            {
              angle = -1;
              children = [
                { angle = -1; data = "AudioMute"; icon = "flypie-multimedia-mute-symbolic-#853"; name = "Mute"; type = "Shortcut"; }
                { angle = -1; data = "AudioPlay"; icon = "flypie-multimedia-playpause-symbolic-#853"; name = "Play / Pause"; type = "Shortcut"; }
                { angle = 90; data = "AudioNext"; icon = "flypie-multimedia-next-symbolic-#853"; name = "Next Title"; type = "Shortcut"; }
                { angle = 270; data = "AudioPrev"; icon = "flypie-multimedia-previous-symbolic-#853"; name = "Previous Title"; type = "Shortcut"; }
              ];
              data = { };
              icon = "org.gnome.Settings-sound-symbolic";
              name = "Sound";
              showLabels = false;
              type = "CustomMenu";
            }
            {
              angle = -1;
              children = [
                { angle = -1; data = { command = "flatpak run --branch=stable --arch=x86_64 --command=emblem org.gnome.design.Emblem"; }; icon = "org.gnome.design.Emblem"; name = "Emblem"; type = "Command"; }
                { angle = -1; data = { command = "inkscape %F"; }; icon = "org.inkscape.Inkscape"; name = "Inkscape Vector Graphics Editor"; type = "Command"; }
                { angle = -1; data = { command = "gimp-2.10 %U"; }; icon = "gimp"; name = "GNU Image Manipulation Program"; type = "Command"; }
                { angle = -1; data = { command = "flatpak run --branch=stable --arch=x86_64 --command=icon-library org.gnome.design.IconLibrary"; }; icon = "org.gnome.design.IconLibrary"; name = "Icon Library"; type = "Command"; }
                { angle = -1; data = { command = "flatpak run --branch=stable --arch=x86_64 --command=blender --file-forwarding org.blender.Blender @@ %f @@"; }; icon = "org.blender.Blender"; name = "Blender"; type = "Command"; }
              ];
              data = { };
              icon = "document-edit-symbolic";
              name = "Design";
              showLabels = false;
              type = "CustomMenu";
            }
            {
              angle = -1;
              children = [
                { angle = -1; data = { command = "flatpak run --branch=stable --arch=x86_64 --command=kdenlive --file-forwarding org.kde.kdenlive @@ %F @@"; }; icon = "org.kde.kdenlive"; name = "Kdenlive"; type = "Command"; }
                { angle = -1; data = { command = "flatpak run --branch=stable --arch=x86_64 --command=video-downloader com.github.unrud.VideoDownloader"; }; icon = "com.github.unrud.VideoDownloader"; name = "Video Downloader"; type = "Command"; }
                { angle = -1; data = { command = "obs"; }; icon = "com.obsproject.Studio"; name = "OBS Studio"; type = "Command"; }
              ];
              data = { };
              icon = "video-x-generic-symbolic";
              name = "Video";
              showChildLabels = false;
              showLabels = false;
              type = "CustomMenu";
            }
            {
              angle = -1;
              children = [
                { angle = -1; data = { command = "flatpak run --branch=stable --arch=x86_64 --command=workbench --file-forwarding re.sonny.Workbench @@u %U @@"; }; icon = "re.sonny.Workbench"; name = "Workbench"; type = "Command"; }
                { angle = -1; data = { command = "kgx"; }; icon = "org.gnome.Console"; name = "Console"; type = "Command"; }
                { angle = -1; data = { command = "kgx hx %F"; }; icon = "helix"; name = "Helix"; type = "Command"; }
                { angle = -1; data = { command = "code %F"; }; icon = "code"; name = "Visual Studio Code"; type = "Command"; }
              ];
              data = { };
              icon = "applications-science-symbolic";
              name = "Code";
              showLabels = false;
              type = "CustomMenu";
            }
            {
              angle = -1;
              children = [
                { angle = -1; data = { uri = "https://discord.com/app"; }; icon = "💬️"; name = "Discord"; type = "Uri"; }
                { angle = -1; data = { uri = "https://wetdry.world"; }; icon = "🐘️"; name = "Mastodon"; type = "Uri"; }
                { angle = -1; data = { uri = "https://music.youtube.com"; }; icon = "💿️"; name = "YT Music"; type = "Uri"; }
                { angle = -1; data = { uri = "https://movie-web.app"; }; icon = "📽️"; name = "movie-web"; type = "Uri"; }
              ];
              data = { };
              icon = "web-browser-symbolic";
              name = "Web";
              showLabels = false;
              type = "CustomMenu";
            }
          ];
          data = { };
          icon = "";
          id = 0;
          name = "Sween";
          shortcut = "Launch7";
          showChildLabels = false;
          showLabels = false;
          superRMB = false;
          touchButton = false;
          type = "CustomMenu";
        }];
        text-color = "rgb(222,222,222)";
        trace-color = "rgba(0,0,0,0.462838)";
        trace-min-length = 200.0;
        trace-thickness = 8.0;
        wedge-color = "rgba(0,0,0,0.129992)";
        wedge-color-hover = "rgba(0,0,0,0.0747331)";
        wedge-inner-radius = 43.0;
        wedge-separator-color = "rgba(255, 255, 255, 0.13)";
        wedge-separator-width = 1.0;
        wedge-width = 300.0;
      };

      "org/gnome/shell/extensions/just-perfection" = {
        app-menu = false;
        power-icon = false;
        search = false;
        theme = true;
        top-panel-position = 1;
        switcher-popup-delay = true;
      };

    };
  };
}
