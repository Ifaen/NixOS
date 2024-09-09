# Wiki: https://github.com/Alexays/Waybar/wiki
{
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user.name}.programs.waybar.settings.statusBar = {
    modules-left = [
      "custom/power"
      "custom/app-launcher"
      "idle_inhibitor"
    ];

    "custom/power" = {
      format = "";
      tooltip = false;
      on-click = "wlogout";
    };

    "custom/app-launcher" = {
      format = "󱄅";
      tooltip = false;
      on-click = "pkill wofi || wofi --normal-window --allow-images --show drun";
    };

    idle_inhibitor = {
      format = "{icon}";
      format-icons = {
        activated = "";
        deactivated = "";
      };
    };
  };
}
