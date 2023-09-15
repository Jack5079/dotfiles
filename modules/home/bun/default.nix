{ pkgs, config, lib, ... }:

let
  cfg = config.programs.bun;
in
{
  options.programs.bun = {
    enable = lib.mkEnableOption "Bun JavaScript runtime";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.bun ];
    # https://bun.sh/docs/install/lockfile#how-do-i-git-diff-bun-s-lockfile
    programs.git.attributes = [ "*.lockb binary diff=lockb" ];
    programs.git.extraConfig.diff.lockb = {
      textconv = "bun";
      binary = true;
    };
  };
}
