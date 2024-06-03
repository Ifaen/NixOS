{
  lib,
  user,
  ...
}: {
  networking.networkmanager.enable = true; # Enable networking

  networking.firewall = {
    enable = true;

    allowedTCPPorts = [
      #22 # OpenSSH Port
      #5900 # VNC Server port
      22000 # TCP and/or UDP for sync traffic
      8384 # Syncthing localhost port
    ];

    allowedUDPPorts = [
      #5900 # VNC Server port
      22000 # TCP and/or UDP for sync traffic
      21027 # UDP for discovery
    ];
  };
}
