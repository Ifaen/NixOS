{pkgs, ...}: {
  user.manage.programs.waybar.settings.statusBar = {
    modules-right = [
      "pulseaudio"
      "group/group-clock"
    ];

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
  };
}
