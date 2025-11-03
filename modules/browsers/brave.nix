{pkgs, ...}: {
  user-manage.home.packages = [pkgs.brave];

  user-manage.xdg.desktopEntries."brave" = {
    name = "Brave";
    exec = "brave %U";
    icon = "brave";
    categories = ["X-Rofi"];
  };
}
