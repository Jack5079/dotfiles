{ config, modulesPath, lib, pkgs, ... }:

let
  cfg = config.security.hardened;
in
{
  options.security.hardened = {
    enable = lib.mkEnableOption "hardening";
  };

  config = lib.mkIf cfg.enable (import "${modulesPath}/profiles/hardened.nix" { inherit config lib pkgs; }) // {
    security.unprivilegedUsernsClone = true; # Needed for flatpak
    security.virtualisation.flushL1DataCache = null; # Use kernel default. Hardened uses always: "flushes L1 data cache every time the hypervisor enters the guest.  May incur significant performance cost."
    security.allowSimultaneousMultithreading = true; # "Disabling SMT means that only physical CPU cores will be usable at runtime, potentially at significant performance cost."
    # https://xeiaso.net/blog/paranoid-nixos-2021-07-18
    security.sudo.execWheelOnly = true;
    nix.allowedUsers = [ "@wheel" ];
    environment.defaultPackages = lib.mkForce [ ]; # Currently only perl, rsync, and strace
  };
}
