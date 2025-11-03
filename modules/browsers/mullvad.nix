{pkgs, ...}: {
  user-manage.home.packages = [pkgs.mullvad-browser];

  user-manage.xdg.desktopEntries."mullvad-browser" = {
    name = "Mullvad Browser";
    exec = "mullvad-browser %U";
    icon = "mullvad-browser";
    categories = ["X-Rofi"];
  };
}
