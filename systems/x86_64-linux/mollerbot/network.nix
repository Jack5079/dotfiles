{
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant. I wonder why this is already on even though it's commented out

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 3000 5173 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  programs.steam.remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
}
