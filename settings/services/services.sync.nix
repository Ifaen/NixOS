{
  config,
  pkgs,
  user,
  ...
}: {
  services.syncthing = {
    enable = true;
    user = "${user.name}";

    dataDir = "${config.home-manager.users.${user.name}.xdg.userDirs.extraConfig.sync}"; # Obtain the name of sync folder in the extraconfig of xdg
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

      "Wallpapers" = {
        path = "${config.home-manager.users.${user.name}.xdg.userDirs.pictures}/Wallpapers/Mobile";
        type = "sendonly";
        devices = ["mobile"];
      };
    };
  };
}
