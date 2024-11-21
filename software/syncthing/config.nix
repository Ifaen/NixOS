{user, ...}: {
  services.syncthing = {
    enable = true;
    user = user.name;

    dataDir = user.dir.sync; # Obtain the name of sync folder in the extraconfig of xdg
    configDir = "${user.dir.config}/syncthing";

    # overrides any folders and devices added or deleted through the WebUI
    overrideDevices = true;
    overrideFolders = true;
  };

  networking.firewall = {
    allowedTCPPorts = [
      22000 # TCP and/or UDP for sync traffic
      8384 # Syncthing localhost port
    ];

    allowedUDPPorts = [
      22000 # TCP and/or UDP for sync traffic
      21027 # UDP for discovery
    ];
  };
}
