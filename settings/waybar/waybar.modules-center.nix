# Wiki: https://github.com/Alexays/Waybar/wiki
{
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user.name}.programs.waybar.settings.statusBar = {
    modules-center = ["hyprland/workspaces"];

    "hyprland/workspaces" = {
      format = "{windows}";
      format-window-separator = " ";
      window-rewrite-default = "󱔢";
      # Other windows rewrite are in files depending of the class of the app
    };
  };
}
