{
  config,
  pkgs,
  user,
  ...
}: {
  services.syncthing = {
    enable = true;
    user = "${user.name}";

    dataDir = config.user.manage.xdg.userDirs.extraConfig.sync; # Obtain the name of sync folder in the extraconfig of xdg
    configDir = "${user.home}/.config/syncthing";

    # overrides any folders and devices added or deleted through the WebUI
    overrideDevices = true;
    overrideFolders = true;

    settings.devices."mobile".id = "FDD6P6K-OV6LVEX-BPUKI6F-2CCANDX-KAHGOSV-5JTU4BC-NISJSGW-3YES5QX";

    settings.folders = {
      "MoveTo" = {
        path = "${config.services.syncthing.dataDir}/MoveTo";
        devices = ["mobile"];
      };

      "Notes" = {
        path = "${config.services.syncthing.dataDir}/Notes";
        devices = ["mobile"];
      };

      "Wallpapers" = {
        path = "${config.user.manage.xdg.userDirs.extraConfig.wallpapers}/Mobile";
        type = "sendonly";
        devices = ["mobile"];
      };
    };
  };
}
