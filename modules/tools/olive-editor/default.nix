{pkgs, ...}: {
  user-manage.home.packages = [pkgs.olive-editor];

  user-manage.xdg.desktopEntries."olive-editor" = {
    name = "Olive Editor";
    # Add gsettings-desktop-schemas and gtk3 to XDG_DATA_DIRS for this software
    exec = "env XDG_DATA_DIRS=${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}:XDG_DATA_DIRS olive-editor";
    icon = "olive-editor";
    categories = ["X-Rofi"];
  };

  user-manage.hyprland.windowrulev2 = ["float, class:(olive-editor)"];
}
