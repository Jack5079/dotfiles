{ config, modulesPath, lib, ... }:

{
  imports = [
    "${modulesPath}/profiles/hardened.nix"
  ];

  config = {
    # Needed for flatpak
    security.unprivilegedUsernsClone = lib.mkForce true;
    security.allowUserNamespaces = lib.mkForce true;
    security.virtualisation.flushL1DataCache = null; # Use kernel default. Hardened uses always: "flushes L1 data cache every time the hypervisor enters the guest.  May incur significant performance cost."
    security.allowSimultaneousMultithreading = true; # "Disabling SMT means that only physical CPU cores will be usable at runtime, potentially at significant performance cost."
    # https://xeiaso.net/blog/paranoid-nixos-2021-07-18
    security.sudo.execWheelOnly = true;
    environment.defaultPackages = lib.mkForce [ ]; # Currently only perl, rsync, and strace
    # Avoid TOFU MITM with git hosts by providing their public keys here.
    programs.ssh.knownHosts = {
      "github.com".hostNames = [ "github.com" ];
      "github.com".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";

      "gitlab.com".hostNames = [ "gitlab.com" ];
      "gitlab.com".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAfuCHKVTjquxvt6CM6tdG4SLp1Btn/nOeHHE5UOzRdf";

      "git.sr.ht".hostNames = [ "git.sr.ht" ];
      "git.sr.ht".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMZvRd4EtM7R+IHVMWmDkVU3VLQTSwQDSAvW0t2Tkj60";
    };
  }
  // lib.mkIf config.programs.virt-manager.enable {
    # https://github.com/NixOS/nixpkgs/issues/223594#issuecomment-1527956398
    boot.kernelModules = [ "kvm-amd" "evdev" "nf" "nf_nat" "nft_chain_nat" "nf_ct" "xt_conntrack" "nf_conntrack" "xt_CHECKSUM" "xt_MASQUERADE" "ipt_REJECT" "nf_reject_ipv4" "snd_hnd_core" "snd" "udp_diag" "edac_mce_amd" "edac_core" "syscopyarea" "ip6_tables" "vhost" "vhost_net" "vhost_iotlb" "xhci_pci" ];
  };
}
