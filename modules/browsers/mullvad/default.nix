{
  config,
  pkgs,
  lib,
  ...
}: {
  options.mullvad-browser.enable = lib.mkEnableOption "Enable Mullvad Browser";

  config = lib.mkIf config.mullvad-browser.enable {
    user-manage.home.packages = [pkgs.mullvad-browser];

    user-manage.xdg.desktopEntries."mullvad-browser" = {
      name = "Mullvad Browser";
      exec = "mullvad-browser %U";
      icon = "mullvad-browser";
      categories = ["X-Rofi"];
    };
  };
}
