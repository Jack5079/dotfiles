{ config, lib, ... }:

let
  cfg = config.programs.virt-manager;
in
{
  options.programs.virt-manager = {
    enable = lib.mkEnableOption "virt-manager";
  };

  config = lib.mkIf cfg.enable
    {
      virtualisation.libvirtd.enable = true;
    };
}
