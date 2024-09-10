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
      "custom/vpn"
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

    "custom/vpn" = {
      format = "󰖂";
      tooltip = false;
      on-click = "${pkgs.writeShellScript "toggle-vpn" ''
        SERVICE_NAME="openvpn-protonvpn.service"
        VPN_STATUS=$(systemctl is-active $SERVICE_NAME)

        if [ "$VPN_STATUS" == "active" ]; then
            systemctl stop $SERVICE_NAME # without sudo, so polkit is prompted
            ${pkgs.libnotify}/bin/notify-send "VPN Stopped"
        else
            systemctl start $SERVICE_NAME
            ${pkgs.libnotify}/bin/notify-send "VPN Started"
        fi
      ''}";
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
