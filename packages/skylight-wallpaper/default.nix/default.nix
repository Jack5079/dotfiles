{ pkgs, lib }: pkgs.writeTextFile {
  name = "skylight-wallpaper";
  text = ''
    <?xml version="1.0"?>
    <!DOCTYPE wallpapers SYSTEM "gnome-wp-list.dtd">
    <wallpapers>
      <wallpaper deleted="false">
        <name>Skylight</name>
        <filename>${./light.png}</filename>
        <filename-dark>${./dark.png}</filename-dark>
        <options>zoom</options>
        <shade_type>solid</shade_type>
        <pcolor>#ffffff</pcolor>
        <scolor>#000000</scolor>
      </wallpaper>
    </wallpapers>
  '';
  destination = "/share/gnome-background-properties/skylight.xml";
  meta = {
    description = "Etcetera's brand wallpaper";
    platforms = lib.platforms.all;
    license = lib.licenses.cc-by-sa-40;
  };
}
