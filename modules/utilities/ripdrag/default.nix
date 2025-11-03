{pkgs, ...}: {
  user-manage.home.packages = [pkgs.ripdrag];

  user-manage.hyprland.windowrulev2 = [
    "pin, class:(it.catboy.ripdrag)"
  ];
}
