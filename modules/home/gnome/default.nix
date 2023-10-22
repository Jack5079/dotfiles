{ lib, osConfig, pkgs, ... }:

{
  config = lib.mkIf osConfig.services.xserver.desktopManager.gnome.enable {
    # GSConnect was installed in systems/x84_64-linux/mollerbot/phone.nix when I set programs.kdeconnect.package
    home.packages = with pkgs.gnomeExtensions; [
      tray-icons-reloaded
      hot-edge
      just-perfection
      paperwm
      overview-background
      wayland-or-x11
    ] ++ [
      pkgs.adw-gtk3
      pkgs.gnome.gnome-tweaks
    ];

    dconf.settings = {
      "org/gnome/GWeather4" = {
        temperature-unit = "fahrenheit";
      };

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
      };

      "org/gnome/shell" = {
        disable-user-extensions = false;
        disabled-extensions = [ "activate_gnome@isjerryxiao" "screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com" "user-theme@gnome-shell-extensions.gcampax.github.com" "activities-filled-pill@verdre" "lightshell@dikasp.gitlab" "paperwm@hedning:matrix.org" ];
        enabled-extensions = [ "gsconnect@andyholmes.github.io" "trayIconsReloaded@selfmade.pl" "flypie@schneegans.github.com" "switch-x11-wayland@prasanthc41m.github.com" "remove-alt-tab-delay@vrba.dev" "light-style@gnome-shell-extensions.gcampax.github.com" "overviewbackground@github.com.orbitcorrection" "just-perfection-desktop@just-perfection" "hotedge@jonathan.jdoda.ca" "waylandorx11@injcristianrojas.github.com" ];
        favorite-apps = [ "firefox.desktop" "code.desktop" "org.gnome.Console.desktop" "com.github.micahflee.torbrowser-launcher.desktop" "org.gnome.Nautilus.desktop" "gimp.desktop" "org.inkscape.Inkscape.desktop" "org.gnome.design.IconLibrary.desktop" "org.kde.kdenlive.desktop" "com.github.unrud.VideoDownloader.desktop" "com.obsproject.Studio.desktop" "org.blender.Blender.desktop" "obsidian.desktop" "steam.desktop" "org.prismlauncher.PrismLauncher.desktop" "org.yuzu_emu.yuzu.desktop" "element-desktop.desktop" "dev.vlinkz.NixSoftwareCenter.desktop" "org.gnome.Software.desktop" ];
        welcome-dialog-last-shown-version = "43.2";
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
        menu-configuration = "[{\"name\":\"Sween\",\"icon\":\"\",\"shortcut\":\"Launch7\",\"centered\":false,\"id\":0,\"children\":[{\"name\":\"Sound\",\"icon\":\"org.gnome.Settings-sound-symbolic\",\"children\":[{\"name\":\"Mute\",\"icon\":\"flypie-multimedia-mute-symbolic-#853\",\"type\":\"Shortcut\",\"data\":\"AudioMute\",\"angle\":-1},{\"name\":\"Play / Pause\",\"icon\":\"flypie-multimedia-playpause-symbolic-#853\",\"type\":\"Shortcut\",\"data\":\"AudioPlay\",\"angle\":-1},{\"name\":\"Next Title\",\"icon\":\"flypie-multimedia-next-symbolic-#853\",\"type\":\"Shortcut\",\"data\":\"AudioNext\",\"angle\":90},{\"name\":\"Previous Title\",\"icon\":\"flypie-multimedia-previous-symbolic-#853\",\"type\":\"Shortcut\",\"data\":\"AudioPrev\",\"angle\":270}],\"type\":\"CustomMenu\",\"data\":{},\"angle\":-1,\"showLabels\":false},{\"name\":\"Design\",\"icon\":\"document-edit-symbolic\",\"type\":\"CustomMenu\",\"children\":[{\"name\":\"Emblem\",\"icon\":\"org.gnome.design.Emblem\",\"type\":\"Command\",\"data\":{\"command\":\"flatpak run --branch=stable --arch=x86_64 --command=emblem org.gnome.design.Emblem\"},\"angle\":-1},{\"name\":\"Inkscape Vector Graphics Editor\",\"icon\":\"org.inkscape.Inkscape\",\"type\":\"Command\",\"data\":{\"command\":\"inkscape %F\"},\"angle\":-1},{\"name\":\"GNU Image Manipulation Program\",\"icon\":\"gimp\",\"type\":\"Command\",\"data\":{\"command\":\"gimp-2.10 %U\"},\"angle\":-1},{\"name\":\"Icon Library\",\"icon\":\"org.gnome.design.IconLibrary\",\"type\":\"Command\",\"data\":{\"command\":\"flatpak run --branch=stable --arch=x86_64 --command=icon-library org.gnome.design.IconLibrary\"},\"angle\":-1},{\"name\":\"Blender\",\"icon\":\"org.blender.Blender\",\"type\":\"Command\",\"data\":{\"command\":\"flatpak run --branch=stable --arch=x86_64 --command=blender --file-forwarding org.blender.Blender @@ %f @@\"},\"angle\":-1}],\"angle\":-1,\"data\":{},\"showLabels\":false},{\"name\":\"Video\",\"icon\":\"video-x-generic-symbolic\",\"type\":\"CustomMenu\",\"children\":[{\"name\":\"Kdenlive\",\"icon\":\"org.kde.kdenlive\",\"type\":\"Command\",\"data\":{\"command\":\"flatpak run --branch=stable --arch=x86_64 --command=kdenlive --file-forwarding org.kde.kdenlive @@ %F @@\"},\"angle\":-1},{\"name\":\"Video Downloader\",\"icon\":\"com.github.unrud.VideoDownloader\",\"type\":\"Command\",\"data\":{\"command\":\"flatpak run --branch=stable --arch=x86_64 --command=video-downloader com.github.unrud.VideoDownloader\"},\"angle\":-1},{\"name\":\"OBS Studio\",\"icon\":\"com.obsproject.Studio\",\"type\":\"Command\",\"data\":{\"command\":\"obs\"},\"angle\":-1}],\"angle\":-1,\"data\":{},\"showLabels\":false,\"showChildLabels\":false},{\"name\":\"Code\",\"icon\":\"applications-science-symbolic\",\"type\":\"CustomMenu\",\"children\":[{\"name\":\"Workbench\",\"icon\":\"re.sonny.Workbench\",\"type\":\"Command\",\"data\":{\"command\":\"flatpak run --branch=stable --arch=x86_64 --command=workbench --file-forwarding re.sonny.Workbench @@u %U @@\"},\"angle\":-1},{\"name\":\"Console\",\"icon\":\"org.gnome.Console\",\"type\":\"Command\",\"data\":{\"command\":\"kgx\"},\"angle\":-1},{\"name\":\"Helix\",\"icon\":\"helix\",\"type\":\"Command\",\"data\":{\"command\":\"kgx hx %F\"},\"angle\":-1},{\"name\":\"Visual Studio Code\",\"icon\":\"code\",\"type\":\"Command\",\"data\":{\"command\":\"code %F\"},\"angle\":-1}],\"angle\":-1,\"data\":{},\"showLabels\":false},{\"name\":\"Web\",\"icon\":\"web-browser-symbolic\",\"type\":\"CustomMenu\",\"children\":[{\"name\":\"Discord\",\"icon\":\"💬️\",\"type\":\"Uri\",\"data\":{\"uri\":\"https://discord.com/app\"},\"angle\":-1},{\"name\":\"Misskey\",\"icon\":\"😺️\",\"type\":\"Uri\",\"data\":{\"uri\":\"https://owo.community\"},\"angle\":-1},{\"name\":\"Mastodon\",\"icon\":\"🐘️\",\"type\":\"Uri\",\"data\":{\"uri\":\"https://wetdry.world\"},\"angle\":-1},{\"name\":\"YT Music\",\"icon\":\"💿️\",\"type\":\"Uri\",\"data\":{\"uri\":\"https://music.youtube.com\"},\"angle\":-1},{\"name\":\"movie-web\",\"icon\":\"📽️\",\"type\":\"Uri\",\"data\":{\"uri\":\"https://movie-web.app\"},\"angle\":-1}],\"angle\":-1,\"data\":{},\"showLabels\":false}],\"type\":\"CustomMenu\",\"data\":{},\"touchButton\":false,\"superRMB\":false,\"showLabels\":false,\"showChildLabels\":false}]";
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
      };

    };
  };
}
