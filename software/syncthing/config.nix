{
  config,
  pkgs,
  user,
  ...
}: {
  services.syncthing = {
    enable = true;
    user = user.name;

    dataDir = config.user.manage.xdg.userDirs.extraConfig.sync; # Obtain the name of sync folder in the extraconfig of xdg
    configDir = "${config.user.manage.xdg.configHome}/syncthing";

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
