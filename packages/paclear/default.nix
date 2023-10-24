{ lib, buildGoModule, fetchFromGitHub, ... }:
buildGoModule rec {
  pname = "paclear";
  version = "0.0.12";

  src = fetchFromGitHub {
    owner = "orangekame3";
    repo = "paclear";
    rev = "v${version}";
    hash = "sha256-Pkp77Ho0+9fsOiuI57wUSc0jCv8EtaJ3NMDp3hs/yCA=";
  };

  vendorHash = "sha256-VE3nnUO3A/HkaoGXef+zuPT2VubWiDfiiSils0F0l74=";

  meta = with lib; {
    description = "paclear is a clear command with PAC-MAN animation";
    homepage = "https://github.com/orangekame3/paclear";
    license = licenses.mit;
    mainProgram = "paclear";
  };
}
