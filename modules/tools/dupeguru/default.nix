{pkgs, ...}: {
  user-manage.home.packages = [pkgs.dupeguru];

  user-manage.xdg.desktopEntries."dupeguru" = {
    name = "DupeGuru";
    exec = "dupeguru";
    icon = "dupeguru";
    categories = ["X-Rofi"];
  };
}
