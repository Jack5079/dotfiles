{ lib, pkgs }: lib.me.patchOutput pkgs.vesktop ''
  rm -r $out/share/icons
  mkdir -p $out/share/icons/hicolor/scalable/apps/
  cp ${./vesktop.svg} $out/share/icons/hicolor/scalable/apps/vesktop.svg
''
