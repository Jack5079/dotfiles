{ osConfig, lib, pkgs, ... }:

let
  cfg = osConfig.programs.virt-manager;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = [pkgs.virt-manager];
  };
}
