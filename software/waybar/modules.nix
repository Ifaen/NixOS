{
  lib,
  pkgs,
  user,
  ...
}: {
  user-manage.programs.waybar.settings.statusBar =
    {
      # Modules Center
      modules-center = ["hyprland/workspaces"];

      modules-left =
        [
          "custom/power"
          "custom/app-launcher"
          "custom/wallpaper-launcher"
          "idle_inhibitor"
        ]
        ++ lib.optional (user.machine == "desktop") [
          "custom/vpn"
        ];

      modules-right =
        lib.optional (user.machine == "notebook") "battery"
        ++ [
          "pulseaudio"
          "group/group-clock"
        ];

      battery = {
        interval = 60;
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{icon} {capacity}%";
        format-icons = ["" "" "" "" ""];
        max-length = 25;
      };

      "hyprland/workspaces" = {
        format = "{windows}";
        format-window-separator = ""; # Empty, for tooltips that used the window-rewrite-default
        window-rewrite-default = "󱔢 ";
        # Other windows rewrite are in files depending of the class of the app, under the alias: waybar-workspace-icon
      };

      "custom/power" = {
        format = "";
        tooltip = false;
        on-click = "wlogout -b 4";
      };

      "custom/app-launcher" = {
        format = "󱄅";
        tooltip = false;
        on-click = "${pkgs.writeShellScript "toggle-rofi" ''
          if pgrep rofi; then
            pkill rofi
          else
            # If rofi is not running, start it
            hyprctl dispatch exec "${pkgs.rofi}/bin/rofi -show drun -show-icons -drun-categories 'X-Rofi'"
          fi
        ''}";
      };

      "custom/wallpaper-launcher" = {
        format = "";
        tooltip = false;
        on-click = "${pkgs.writeShellScript "toggle-waypaper" ''
          if pgrep waypaper; then
            pkill waypaper
          else
            hyprctl dispatch exec ${pkgs.waypaper}/bin/waypaper
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

      pulseaudio = {
        format = "{icon} {volume}%";
        format-muted = " off";
        format-icons = {
          default = [
            " "
            " "
          ];
        };

        scroll-step = 5;
        on-click = "pkill pavucontrol || pavucontrol";
        on-click-right = "${
          pkgs.writeShellScript "toggle-mute.sh" ''
            mute_status=$(${pkgs.pulseaudio}/bin/pactl get-sink-mute 0 | awk '{print $2}')

            if [ "$mute_status" = "yes" ]; then
              ${pkgs.pulseaudio}/bin/pactl set-sink-mute 0 0
            else
              ${pkgs.pulseaudio}/bin/pactl set-sink-mute 0 1
            fi
          ''
        }";
      };

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
    }
    // lib.optionalAttrs (user.machine == "desktop") {
      "custom/vpn" = {
        format = "󰖂";
        tooltip = false;
        on-click = "${pkgs.writeShellScript "toggle-vpn" ''
          SERVICE_NAME="openvpn-protonvpn.service"

          VPN_STATUS=$(systemctl is-active $SERVICE_NAME) # Check if is active

          if [ "$VPN_STATUS" == "active" ]; then
            systemctl stop $SERVICE_NAME # without sudo, so polkit is prompted
          else
            systemctl start $SERVICE_NAME
          fi

          # Check new status
          VPN_STATUS_AFTER=$(systemctl is-active $SERVICE_NAME) # Re-check

          if [ "$VPN_STATUS_AFTER" == "$VPN_STATUS" ]; then
            ${pkgs.libnotify}/bin/notify-send "Cancelled."
          elif [ "$VPN_STATUS_AFTER" == "active" ]; then
            ${pkgs.libnotify}/bin/notify-send "VPN Started"
          else
            ${pkgs.libnotify}/bin/notify-send "VPN Stopped"
          fi
        ''}";
      };
    };
}
