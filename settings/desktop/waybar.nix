# Wiki: https://github.com/Alexays/Waybar/wiki
{
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user.name} = {
    programs.waybar = {
      enable = true;

      settings.statusBar =
        {
          # General configuration
          layer = "top"; # Enables that when right clicked or hovered, the context menu is upfront
          reload_style_on_change = true;

          # LEFT
          modules-left =
            [
              "custom/power"
              "pulseaudio"
            ]
            ++ (
              if user.machine == "notebook"
              then ["backlight"]
              else []
            )
            ++ ["idle_inhibitor"];

          # CENTER
          modules-center = ["hyprland/workspaces"];

          # RIGHT
          modules-right =
            [
              "group/group-clock"
              "memory"
              "cpu"
            ]
            ++ (
              if user.machine == "desktop"
              then ["group/group-gpu"]
              else ["battery"]
            )
            ++ [
              "temperature"
              "custom/weather"
            ];

          "custom/power" = {
            format = "";
            tooltip = false;
            on-click = "wlogout";
          };

          "custom/weather" = {
            format = "{}°C";
            tooltip = true;
            interval = 36000;
            exec = "${pkgs.wttrbar}/bin/wttrbar --location 'Punta Arenas'";
            return-type = "json";
          };

          cpu = {
            interval = 10;
            format = "  {usage}%";
            max-length = 10;
          };

          idle_inhibitor = {
            format = "{icon}";
            format-icons = {
              activated = "";
              deactivated = "";
            };
          };

          "hyprland/workspaces" = {
            format = "{windows}";
            format-window-separator = " ";
            window-rewrite-default = "󱔢";
            # Other windows rewrite are in files depending of the class of the app
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

          memory = {
            interval = 10;
            format = " {}%";
            max-length = 10;
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

          temperature = {
            format = " {temperatureC}°C";
            "critical-threshold" = 90;
            "format-critical" = " {temperatureC}°C";
          };
        }
        // (
          if user.machine == "desktop"
          then {
            "group/group-gpu" = {
              orientation = "horizontal";
              modules = [
                "custom/gpu-icon"
                "custom/gpu-usage"
              ];
            };
            "custom/gpu-icon" = {
              format = "󰢮";
              tooltip = false;
            };
            "custom/gpu-usage" = {
              exec = "${pkgs.writeShellScript "gpu-busy-percent-output" ''
                if [ -f /tmp/gpu_busy_percent_path ]; then
                  echo "$(cat /tmp/gpu_busy_percent_path)"
                  exit 0
                fi
                for hwmon_folder in /sys/class/hwmon/hwmon*; do
                  if [ -d "$hwmon_folder/device" ]; then
                    if [ -f "$hwmon_folder/device/gpu_busy_percent" ]; then
                      ln -sf "$hwmon_folder/device/gpu_busy_percent" /tmp/gpu_busy_percent_path
                      exit 0
                    fi
                  fi
                done
                echo "ERROR"
                exit 1
              ''}";
              format = "{}%";
              tooltip = false;
              interval = 10; # Refresh every second
            };
          }
          else {
            battery = {
              bat = "BAT2";
              interval = 60;
              states = {
                warning = 30;
                critical = 15;
              };
              format = "{capacity}% {icon}";
              format-icons = ["" "" "" "" ""];
              max-length = 25;
            };
            backlight = {
              device = "intel_backlight";
              format = "{percent}% {icon}";
              format-icons = ["" ""];
            };
          }
        );

      style = ''
        @import "${user.home}/.cache/wal/colors-waybar.css";        /* For the color scheme */
        @import "${user.flake}/shared/styles/waybar.css";  /* For the styling*/
      '';
    };

    # Settings of waybar in other modules
    wayland.windowManager.hyprland.settings.exec-once = ["waybar"];
  };
}
