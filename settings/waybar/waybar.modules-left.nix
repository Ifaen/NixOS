# Wiki: https://github.com/Alexays/Waybar/wiki
{
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user.name}.programs.waybar.settings.statusBar = {
    modules-left = [
      "custom/power"
      "pulseaudio"
      "idle_inhibitor"
    ];

    "custom/power" = {
      format = "";
      tooltip = false;
      on-click = "wlogout";
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

    idle_inhibitor = {
      format = "{icon}";
      format-icons = {
        activated = "";
        deactivated = "";
      };
    };
  };
}
