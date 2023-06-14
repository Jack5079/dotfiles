{ lib, stdenvNoCC, ... }: stdenvNoCC.mkDerivation {
  name = "extra-fonts";
  meta = with lib; {
    description = "A collection of nonfree fonts I illegally downloaded from the Internet";
    license = licenses.unfree;
    platforms = platforms.all;
  };
  src = ./.;
  installPhase = ''
    mkdir -pv $out/share/fonts/truetype
    cp -v *.ttf $out/share/fonts/truetype
  '';
}
