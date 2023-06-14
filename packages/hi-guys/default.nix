{ writeScriptBin, mpg123, ... }:
writeScriptBin
  "hi-guys"
  ''
    echo "👋"
    ${mpg123}/bin/mpg123 -q ${./higuys.mp3} 2>/dev/null &
  ''
