{pkgs, ...}: {
  user-manage.programs.chromium = {
    enable = true;

    package = pkgs.google-chrome;
  };

  user-manage.xdg.desktopEntries."google-chrome" = {
    name = "Google Chrome";
    exec = "google-chrome-stable %U";
    icon = "google-chrome";
    categories = ["X-Rofi"];
  };
}
