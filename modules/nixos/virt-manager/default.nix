{ config, lib, ... }:

let
  cfg = config.programs.virt-manager;
in
{
  config = lib.mkIf cfg.enable
    {
      virtualisation.libvirtd.enable = true;
    };
}
