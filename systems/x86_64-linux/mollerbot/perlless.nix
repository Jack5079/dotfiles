{ config, ... }: {
  system.switch.enable = false;
  system.switch.enableNg = true;

  # Remove perl from activation
  boot.initrd.systemd.enable = true;
  system.etc.overlay.enable = true;
  systemd.sysusers.enable = true;

  # Random perl remnants
  system.disableInstallerTools = true;
  programs.less.lessopen = null;
  programs.command-not-found.enable = false;
  boot.enableContainers = false;
  environment.defaultPackages = [ ];
  environment.systemPackages = [
    config.system.build.nixos-rebuild
  ];
  documentation.info.enable = false;

  # Check that the system does not contain a Nix store path that contains the
  # string "perl".
  system.forbiddenDependenciesRegexes = [ "perl" ];
}
