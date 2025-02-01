{
  config,
  user,
  ...
}: {
  services.syncthing.settings = {
    devices."mobile".id = "FDD6P6K-OV6LVEX-BPUKI6F-2CCANDX-KAHGOSV-5JTU4BC-NISJSGW-3YES5QX";

    folders = {
      "MoveTo" = {
        path = "${config.services.syncthing.dataDir}/MoveTo";
        devices = ["mobile"];
      };

      "Notes" = {
        path = "${config.services.syncthing.dataDir}/Notes";
        devices = ["mobile"];
      };

      "Wallpapers" = {
        path = "${user.wallpapers}/Mobile";
        type = "sendonly";
        devices = ["mobile"];
      };
    };
  };
}
