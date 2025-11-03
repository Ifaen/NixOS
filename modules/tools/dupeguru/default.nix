{
  config,
  pkgs,
  lib,
  ...
}: {
  options.dupeguru.enable = lib.mkEnableOption "Enable DupeGuru";

  config = lib.mkIf config.dupeguru.enable {
    user-manage.home.packages = [pkgs.dupeguru];

    user-manage.xdg.desktopEntries."dupeguru" = {
      name = "DupeGuru";
      exec = "dupeguru";
      icon = "dupeguru";
      categories = ["X-Rofi"];
    };
  };
}
