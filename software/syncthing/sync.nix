{
  config,
  user,
  ...
}: {
  services.syncthing.settings = {
    devices."mobile".id = "ROD5HSV-O44ZROZ-JONTSKH-M5TODM6-3NLS5RR-YOSQUEJ-JIWCKM4-LJUFDQM";

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
