{pkgs, ...}: {
  user.manage.qt = {
    enable = true;

    platformTheme.name = "gtk3";

    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };
}
