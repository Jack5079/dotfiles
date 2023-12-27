{ lib, pkgs }: lib.me.patchOutput pkgs.vesktop ''
  rm -r $out/share/icons
  mkdir -p $out/share/icons/hicolor/scalable/apps/
  cp ${./vencorddesktop.svg} $out/share/icons/hicolor/scalable/apps/vencorddesktop.svg
''
