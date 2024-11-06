{
  config,
  pkgs,
  user,
  ...
}: let
  wal-directory = "${user.home}/.cache/wal";

  wallpaper-change = "${pkgs.writeShellScript "wallpaper-change" ''
    current_wallpaper=$(basename $(cat ${user.home}/.cache/swww/${user.monitor}))  # Obtain the current wallpaper filename

    case $1 in
      "up")
        bool="0"
        for file in ${config.home-manager.users.${user.name}.xdg.userDirs.extraConfig.wallpapers}/*; do                   # Loop directory and rename the file variable
          if [ -f "$file" ]; then                                 # Check if it's a regular file
            file=$(basename "$file")                              # Keep only the filename

            if [ "$bool" == "1" ]; then
              bool="0"    # Stop from renaming "file" variable
              break         # Break the for loop
            fi

            if [ "$file" == "$current_wallpaper" ]; then          # If the filename is the same as the current
              bool="1"                                            # Make variable true and loop once time (if possible)
            fi
          fi
        done

        if [ "$bool" == "1" ]; then                               # If the boolean is still true
          file=$(ls -1 ${config.home-manager.users.${user.name}.xdg.userDirs.extraConfig.wallpapers} | head -n 1)         # Select 1st file from directory
        fi
      ;;

      "down")
        file=""
        for current_file in ${config.home-manager.users.${user.name}.xdg.userDirs.extraConfig.wallpapers}/*; do           # Loop directory and rename the file variable
          if [ -f "$current_file" ]; then                         # Check if it's a regular file
            current_file=$(basename "$current_file")              # Keep only the filename

            if [ "$current_file" == "$current_wallpaper" ]; then  # If the filename is the same as the current
              break
            fi

            file="$current_file"
          fi
        done

        if [ "$file" == "" ]; then                            # If the variable is empty
          file=$(ls -1 ${config.home-manager.users.${user.name}.xdg.userDirs.extraConfig.wallpapers} | tail -n 1)     # Select last file from directory
        fi
      ;;
      *)
        echo "Wrong input"
      ;;
    esac

    # Change the wallpaper with specific parameters. ACCEPTED FILE TYPES: jpg | jpeg | png | gif | pnm | tga | tiff | webp | bmp | farbfeld
    ${pkgs.swww}/bin/swww img ${config.home-manager.users.${user.name}.xdg.userDirs.extraConfig.wallpapers}"/$file" \
      --transition-bezier .43,1.19,1,.4 \
      --transition-fps=60 \
      --transition-type="wipe" \
      --transition-duration=0.7 \
      --transition-pos "$(hyprctl cursorpos)"

    # Pywal
    ${pkgs.pywal}/bin/wal -q -i ${config.home-manager.users.${user.name}.xdg.userDirs.extraConfig.wallpapers}"/$file" # Create color scheme of file
    colors="${wal-directory}/colors" # Obtain new color scheme

    # Make wal for hyprland
    > "${wal-directory}/colors-hyprland.conf" # Clean file

    i=0
    while IFS= read -r line; do
      echo "\$color$i = ''${line#"#"}" >> "${wal-directory}/colors-hyprland.conf" # Append to file
      ((i++))
    done < "$colors" # Read from the path inside the $colors variable

    #sleep 1
    ${pkgs.libnotify}/bin/notify-send "Colors and Wallpaper updated" "with image $file"
  ''}";

  workspace-change = "${pkgs.writeShellScript "workspace-change" ''
    # Kill every wofi instance, in case there was one
    pkill wofi

    # Change to provided workspace
    hyprctl dispatch workspace $1

    # Check if workspace is empty
    is_empty=$(hyprctl activeworkspace -j | ${pkgs.jq}/bin/jq '.windows')

    # If empty, open wofi
    if [ $is_empty == 0 ]; then
      hyprctl dispatch exec wofi -- --normal-window --allow-images --show drun
    fi
  ''}";
in {
  home-manager.users.${user.name}.services.xremap.config.keymap = [
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
          "${pkgs.writeShellScript "toggle-wofi" "pkill wofi || wofi --normal-window --allow-images --show drun"}"
        ];

        super-shift-w.launch = [
          "hyprctl"
          "dispatch"
          "exec"
          "${pkgs.writeShellScript "toggle-waybar" "pkill waybar || waybar"}"
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
          # Store the screenshot in the declared XDG_SCREENSHOTS_DIR
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
        super-up.launch = ["${wallpaper-change}" "up"];
        super-down.launch = ["${wallpaper-change}" "down"];

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
        control-shift-alt-up.launch = ["ydotool" "mousemove" "-x" "0" "-y" "-5"];
        control-shift-alt-down.launch = ["ydotool" "mousemove" "-x" "0" "-y" "5"];
        control-shift-alt-left.launch = ["ydotool" "mousemove" "-x" "-5" "-y" "0"];
        control-shift-alt-right.launch = ["ydotool" "mousemove" "-x" "5" "-y" "0"];
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
    # Laziness Mode
    {
      name = "laziness-mode";
      application.only = ["imv" "mpv"];
      remap = {
        delete.launch = ["hyprctl" "dispatch" "killactive"];
      };
    }
  ];
}
