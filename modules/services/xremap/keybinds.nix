{pkgs, ...}: let
in {
  user-manage = {
    services.xremap.config.keymap = [
      # Headphones
      {
        name = "headphones";
        remap = {
          volumeup.launch = [
            # Script to prevent volume going up higher than 100
            "${pkgs.writeShellScript "volume-up.sh" ''
              current_volume=$(${pkgs.pulseaudio}/bin/pactl get-sink-volume @DEFAULT_SINK@ | grep 'Volume: front-left' | awk '{print $5}' | sed 's/%//')
              if [ "$current_volume" -lt 100 ]; then
                ${pkgs.pulseaudio}/bin/pactl set-sink-volume 0 +5%
              fi
            ''}"
          ];

          volumedown.launch = ["${pkgs.pulseaudio}/bin/pactl" "set-sink-volume" "0" "-5%"];
        };
      }
      # Laziness Mode (To ease closing apps opened through lf)
      {
        name = "laziness-mode";
        application.only = ["imv" "mpv" "vlc"];
        remap.delete.launch = ["hyprctl" "dispatch" "killactive"];
      }
    ];
  };
}
