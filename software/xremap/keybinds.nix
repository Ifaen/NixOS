{
  pkgs,
  user,
  ...
}: let
  # Change the wallpaper with specific parameters. ACCEPTED FILE TYPES: jpg | jpeg | png | gif | pnm | tga | tiff | webp | bmp | farbfeld
  on-wallpaper-change = "${pkgs.writeShellScript "on-wallpaper-change" ''
    current_wallpaper=$(basename $(${pkgs.swww}/bin/swww query | head -n 1 | awk -F 'image: ' '{print $2}'))

    directory_wallpaper=${user.dir.wallpapers}

    case $1 in
      "up")
        new_wallpaper=$(command ls "$directory_wallpaper" -p | grep -v / | grep -A 1 "^$current_wallpaper$" | tail -n 1)

        if [[ "$new_wallpaper" == "$current_wallpaper" ]]; then
          new_wallpaper=$(command ls "$directory_wallpaper" -p | grep -v / | head -n 1)
        fi
      ;;

      "down")
        new_wallpaper=$(command ls "$directory_wallpaper" -r -p | grep -v / | grep -A 1 "^$current_wallpaper$" | tail -n 1)

        if [[ "$new_wallpaper" == "$current_wallpaper" ]]; then
          new_wallpaper=$(command ls "$directory_wallpaper" -r -p | grep -v / | head -n 1)
        fi
      ;;
    esac

    ${pkgs.swww}/bin/swww img "$directory_wallpaper/$new_wallpaper" --transition-bezier .43,1.19,1,.4 --transition-fps=60 --transition-type="wipe" --transition-duration=0.7

    ${pkgs.pywal}/bin/wal -q -n -i "$directory_wallpaper/$new_wallpaper"

    extended-pywal-schemes

    ${pkgs.libnotify}/bin/notify-send "Colors and Wallpaper updated" "with image: $new_wallpaper"
  ''}";

  open-rofi = "${pkgs.rofi}/bin/rofi -show drun -show-icons -drun-categories X-Rofi";

  workspace-change = "${pkgs.writeShellScript "workspace-change" ''
    # Kill every instance, in case there was one
    pkill rofi

    # Change to provided workspace
    hyprctl dispatch workspace $1

    # Check if workspace is empty
    is_empty=$(hyprctl activeworkspace -j | ${pkgs.jq}/bin/jq '.windows')

    # If empty, open program
    if [ $is_empty == 0 ]; then
      hyprctl dispatch exec "${open-rofi}"
    fi
  ''}";
in {
  user.manage = {
    # For Grimblast
    xdg.userDirs.extraConfig.XDG_SCREENSHOTS_DIR = user.dir.screenshots;

    services.xremap.config.keymap = [
      # Applications
      {
        name = "applications";
        remap = {
          super-q.launch = [
            "hyprctl"
            "dispatch"
            "killactive"
          ];

          super-w.launch = [
            "hyprctl"
            "dispatch"
            "exec"
            "${pkgs.writeShellScript "toggle-rofi" "pkill rofi || ${open-rofi}"}"
          ];

          # Screenshot utility
          sysrq.launch = [
            "${pkgs.grimblast}/bin/grimblast"
            "--freeze"
            "--notify"
            "copy"
            "area"
          ];
          shift-sysrq.launch = [
            # Store the screenshot in the declared XDG_SCREENSHOTS_DIR env variable
            "${pkgs.grimblast}/bin/grimblast"
            "--freeze"
            "--notify"
            "copysave"
            "area"
          ];
        };
      }
      # Workspace
      {
        name = "workspace";
        remap = {
          # Change wallpaper with super + up and down buttons
          super-up.launch = ["${on-wallpaper-change}" "up"];
          super-down.launch = ["${on-wallpaper-change}" "down"];

          # Change workspace with super + left and right buttons
          super-left.launch = ["hyprctl" "dispatch" "workspace" "e-1"];
          super-right.launch = ["hyprctl" "dispatch" "workspace" "e+1"];

          # Change window with super + shift + arrow keys
          super-shift-up.launch = ["hyprctl" "dispatch" "movefocus" "u"];
          super-shift-down.launch = ["hyprctl" "dispatch" "movefocus" "d"];
          super-shift-left.launch = ["hyprctl" "dispatch" "movefocus" "l"];
          super-shift-right.launch = ["hyprctl" "dispatch" "movefocus" "r"];

          # Move window in the same workspace with super + alt + arrow keys
          super-alt-up.launch = ["hyprctl" "dispatch" "movewindow" "u"];
          super-alt-down.launch = ["hyprctl" "dispatch" "movewindow" "d"];
          super-alt-left.launch = ["hyprctl" "dispatch" "movewindow" "l"];
          super-alt-right.launch = ["hyprctl" "dispatch" "movewindow" "r"];

          # Change size of window with super + ctrl + arrow keys
          super-control-up.launch = ["hyprctl" "dispatch" "resizeactive" "0" "-10"];
          super-control-down.launch = ["hyprctl" "dispatch" "resizeactive" "0" "10"];
          super-control-left.launch = ["hyprctl" "dispatch" "resizeactive" "-10" "0"];
          super-control-right.launch = ["hyprctl" "dispatch" "resizeactive" "10" "0"];

          super-1.launch = ["${workspace-change}" "1"];
          super-2.launch = ["${workspace-change}" "2"];
          super-3.launch = ["${workspace-change}" "3"];
          super-4.launch = ["${workspace-change}" "4"];
          super-5.launch = ["${workspace-change}" "5"];
          super-6.launch = ["${workspace-change}" "6"];
          super-7.launch = ["${workspace-change}" "7"];
          super-8.launch = ["${workspace-change}" "8"];
          super-9.launch = ["${workspace-change}" "9"];
          super-0.launch = ["${workspace-change}" "10"];

          super-shift-1.launch = ["hyprctl" "dispatch" "movetoworkspace" "1"];
          super-shift-2.launch = ["hyprctl" "dispatch" "movetoworkspace" "2"];
          super-shift-3.launch = ["hyprctl" "dispatch" "movetoworkspace" "3"];
          super-shift-4.launch = ["hyprctl" "dispatch" "movetoworkspace" "4"];
          super-shift-5.launch = ["hyprctl" "dispatch" "movetoworkspace" "5"];
          super-shift-6.launch = ["hyprctl" "dispatch" "movetoworkspace" "6"];
          super-shift-7.launch = ["hyprctl" "dispatch" "movetoworkspace" "7"];
          super-shift-8.launch = ["hyprctl" "dispatch" "movetoworkspace" "8"];
          super-shift-9.launch = ["hyprctl" "dispatch" "movetoworkspace" "9"];
          super-shift-0.launch = ["hyprctl" "dispatch" "movetoworkspace" "10"];

          super-shift-o.launch = ["hyprctl" "dispatch" "togglesplit"];
          super-shift-v.launch = ["hyprctl" "dispatch" "togglefloating"];
        };
      }
      # Cursor Keyboard
      {
        name = "cursor-keyboard";
        remap = {
          control-shift-alt-up.launch = ["ydotool" "mousemove" "--" "0" "-5"];
          control-shift-alt-down.launch = ["ydotool" "mousemove" "--" "0" "5"];
          control-shift-alt-left.launch = ["ydotool" "mousemove" "--" "-5" "0"];
          control-shift-alt-right.launch = ["ydotool" "mousemove" "--" "5" "0"];
        };
      }
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
