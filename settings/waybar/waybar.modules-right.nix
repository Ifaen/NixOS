# Wiki: https://github.com/Alexays/Waybar/wiki
{
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user.name}.programs.waybar.settings.statusBar = {
    modules-right = ["group/group-clock"];

    "group/group-clock" = {
      orientation = "horizontal";
      modules = [
        "clock#clock"
        "clock#calendar"
      ];
    };
    "clock#clock" = {
      format = " {:%H:%M}";
    };
    "clock#calendar" = {
      format = "  {:%d/%m}";
      tooltip-format = "<tt><small>{calendar}</small></tt>";
    };
  };
}
