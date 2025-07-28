{
  config,
  pkgs,
  lib,
  ...
}: {
  options.brave.enable = lib.mkEnableOption "Enable Brave Browser";

  config = lib.mkIf config.brave.enable {
    user-manage.home.packages = [pkgs.brave];

    user-manage.xdg.desktopEntries."brave" = {
      name = "Brave";
      exec = "brave %U";
      icon = "brave";
      categories = ["X-Rofi"];
    };
  };
}
