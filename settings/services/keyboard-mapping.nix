{
  pkgs,
  xremap-flake,
  user,
  ...
}: let
  wallpaperDirectory = "${user.home}/Media/Wallpapers";
  walDirectory = "${user.home}/.cache/wal";
  wallpaper-change = "${pkgs.writeShellScript "wallpaper-change"
    ''
      current_wallpaper=$(basename $(cat ${user.home}/.cache/swww/${user.monitor.name}))  # Obtain the current wallpaper filename

      case $1 in
        "up")
          bool="0"
          for file in ${wallpaperDirectory}/*; do                   # Loop directory and rename the file variable
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
            file=$(ls -1 ${wallpaperDirectory} | head -n 1)         # Select 1st file from directory
          fi
        ;;

        "down")
          file=""
          for current_file in ${wallpaperDirectory}/*; do           # Loop directory and rename the file variable
            if [ -f "$current_file" ]; then                         # Check if it's a regular file
              current_file=$(basename "$current_file")              # Keep only the filename

              if [ "$current_file" == "$current_wallpaper" ]; then  # If the filename is the same as the current
                break
              fi

              file="$current_file"
            fi
          done

          if [ "$file" == "" ]; then                            # If the variable is empty
            file=$(ls -1 ${wallpaperDirectory} | tail -n 1)     # Select last file from directory
          fi
        ;;
        *)
          echo "Wrong input"
        ;;
      esac

      # Change the wallpaper with specific parameters. ACCEPTED FILE TYPES: jpg | jpeg | png | gif | pnm | tga | tiff | webp | bmp | farbfeld
      ${pkgs.swww}/bin/swww img ${wallpaperDirectory}"/$file" \
        --transition-bezier .43,1.19,1,.4 \
        --transition-fps=60 \
        --transition-type="wipe" \
        --transition-duration=0.7 \
        --transition-pos "$(hyprctl cursorpos)"

      # Pywal
      ${pkgs.pywal}/bin/wal -q -i ${wallpaperDirectory}"/$file" # Create color scheme of file
      colors="${walDirectory}/colors"                           # Obtain new color scheme

      i=0
      # Make wal for hyprland
      > "${walDirectory}/colors-hyprland.conf"                  # Clean file

      while IFS= read -r line; do
        echo "\$color$i = ''${line#"#"}" >> "${walDirectory}/colors-hyprland.conf"  # Append to file
        ((i++))
      done < "$colors"                                                              # Read from the path inside the $colors variable

      #sleep 1
      ${pkgs.libnotify}/bin/notify-send "Colors and Wallpaper updated" "with image $file"
    ''}";

  workspace-change = "${pkgs.writeShellScript "workspace-change"
    ''
      tmp_file_previous_workspace="/tmp/hypr_previous_workspace"

      SELECTED_WORKSPACE="$1"
      CURRENT_WORKSPACE=$(echo $(hyprctl -j activewindow | grep '"id"') | awk -F'[:, ]' '{print $3}') # Uses the activewindow function from hyprctl

      # Check if the file exists
      if [ ! -f "$tmp_file_previous_workspace" ]; then
        echo "$CURRENT_WORKSPACE" > "$tmp_file_previous_workspace" # Create the file and write the current workspace number to it
      fi
      PREVIOUS_WORKSPACE=$(cat "$tmp_file_previous_workspace") # Obtain the value from the file

      case $2 in
        "key")
          if (("$CURRENT_WORKSPACE" == "$SELECTED_WORKSPACE")); then  # If the inputted is equal to the current workspace
            hyprctl dispatch workspace $PREVIOUS_WORKSPACE            # Move to the previous workspace
          else                                                        # If not
            hyprctl dispatch workspace $SELECTED_WORKSPACE            # Move to the inputted workspace
            echo "$CURRENT_WORKSPACE" > "$tmp_file_previous_workspace"                       # Then the current workspace becomes the previous
          fi
        ;;
        "arrow")
          hyprctl dispatch workspace $SELECTED_WORKSPACE            # Move to the inputted workspace
          echo "$CURRENT_WORKSPACE" > "$tmp_file_previous_workspace"                       # Then the current workspace becomes the previous
        ;;
        *)
          echo "Wrong input"
        ;;
      esac
    ''}";
in {
  environment.systemPackages = [
    pkgs.wtype # Tool to type any input, even special characters
    pkgs.ydotool # Tool to move cursor using the keyboard
  ];

  # Start service for ydotool to detect inputs
  systemd.user.services.ydotoold = {
    description = "ydotool daemon";
    wantedBy = ["graphical-session.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.ydotool}/bin/ydotoold";
      ExecReload = "${pkgs.util-linux}/bin/kill -HUP $MAINPID";
      KillMode = "Process";
      Restart = "always";
      TimeoutSec = 180;
    };
  };

  hardware.uinput.enable = true;

  users.groups = {
    uinput.members = ["${user.name}"];
    input.members = ["${user.name}"];
  };

  home-manager.users."${user.name}" = {
    imports = [xremap-flake.homeManagerModules.default];

    # Move/resize windows with mainMod + LMB/RMB and dragging
    wayland.windowManager.hyprland.settings.bindm = [
      "SUPER, mouse:272, movewindow" # SUPER + LMB
      "SUPER, mouse:273, resizewindow" # SUPER + RMB
    ];

    services.xremap = {
      enable = true;
      withWlroots = true;
      mouse = true; # Listen to mouse inputs
      watch = true; # Watch for other devices being connected and remapped
      yamlConfig = ''
        keymap:
        - name: applications
          remap:
            control-q:
              launch: ["hyprctl", "dispatch", "killactive"]
            super-w:
              launch: ["hyprctl", "dispatch", "exec", "${pkgs.writeShellScript "toggle-wofi" "pkill wofi || wofi --normal-window --show drun"}"]
            super-shift-w:
              launch: ["hyprctl", "dispatch", "exec", "${pkgs.writeShellScript "toggle-waybar" "pkill waybar || waybar"}"]

            sysrq:
              launch: ["hyprctl", "dispatch", "exec", "${pkgs.writeShellScript "screenshot-freeze" "${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" ${user.home}/Media/Screenshots/$(date +'%s_screen_area.png')"}"]
            control-sysrq:
              launch: ["hyprctl", "dispatch", "exec", "${pkgs.writeShellScript "screenshot-movement" "${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp -o)\" ${user.home}/Media/Screenshots/$(date +'%s_screen.png')"}"]
            control-shift-sysrq:
              launch: ["hyprctl", "dispatch", "exec", "${pkgs.writeShellScript "screenshot-instant" "${pkgs.grim}/bin/grim ${user.home}/Media/Screenshots/$(date +'%s_fullscreen.png')"}"]


        - name: desktop
          remap:
            super-up:
              launch: ["${wallpaper-change}", "up"]
            super-down:
              launch: ["${wallpaper-change}", "down"]

            super-ctrl-down:
              launch: ["hyprctl", "dispatch", "movefocus", "d"]
            super-ctrl-left:
              launch: ["hyprctl", "dispatch", "movefocus", "l"]
            super-ctrl-right:
              launch: ["hyprctl", "dispatch", "movefocus", "r"]
            super-ctrl-up:
              launch: ["hyprctl", "dispatch", "movefocus", "u"]

            super-1:
              launch: ["${workspace-change}", "1", "key"]
            super-2:
              launch: ["${workspace-change}", "2", "key"]
            super-3:
              launch: ["${workspace-change}", "3", "key"]
            super-4:
              launch: ["${workspace-change}", "4", "key"]
            super-5:
              launch: ["${workspace-change}", "5", "key"]
            super-6:
              launch: ["${workspace-change}", "6", "key"]
            super-7:
              launch: ["${workspace-change}", "7", "key"]
            super-8:
              launch: ["${workspace-change}", "8", "key"]
            super-9:
              launch: ["${workspace-change}", "9", "key"]
            super-0:
              launch: ["${workspace-change}", "10", "key"]
            super-space:
              launch: ["${workspace-change}", "11", "key"]
            super-s:
              launch: ["${workspace-change}", "12", "key"]
            super-k:
              launch: ["${workspace-change}", "13", "key"]
            super-m:
              launch: ["${workspace-change}", "14", "key"]

            super-left:
              launch: ["${workspace-change}", "e-1", "arrow"]
            super-right:
              launch: ["${workspace-change}", "e+1", "arrow"]
            super-xhires_downscroll:
              launch: ["${workspace-change}", "e+1", "arrow"]
            super-xhires_upscroll:
              launch: ["${workspace-change}", "e-1", "arrow"]

            super-shift-1:
              launch: ["hyprctl", "dispatch", "movetoworkspace", "1"]
            super-shift-2:
              launch: ["hyprctl", "dispatch", "movetoworkspace", "2"]
            super-shift-3:
              launch: ["hyprctl", "dispatch", "movetoworkspace", "3"]
            super-shift-4:
              launch: ["hyprctl", "dispatch", "movetoworkspace", "4"]
            super-shift-5:
              launch: ["hyprctl", "dispatch", "movetoworkspace", "5"]
            super-shift-6:
              launch: ["hyprctl", "dispatch", "movetoworkspace", "6"]
            super-shift-7:
              launch: ["hyprctl", "dispatch", "movetoworkspace", "7"]
            super-shift-8:
              launch: ["hyprctl", "dispatch", "movetoworkspace", "8"]
            super-shift-9:
              launch: ["hyprctl", "dispatch", "movetoworkspace", "9"]
            super-shift-0:
              launch: ["hyprctl", "dispatch", "movetoworkspace", "10"]
            super-shift-space:
              launch: ["hyprctl", "dispatch", "movetoworkspace", "11"]
            super-shift-s:
              launch: ["hyprctl", "dispatch", "movetoworkspace", "12"]
            super-shift-k:
              launch: ["hyprctl", "dispatch", "movetoworkspace", "13"]
            super-shift-m:
              launch: ["hyprctl", "dispatch", "movetoworkspace", "14"]

            super-shift-o:
              launch: ["hyprctl", "dispatch", "togglesplit"]
            super-shift-v:
              launch: ["hyprctl", "dispatch", "togglefloating"]


        - name: tildes
          remap:
            alt-a:
              launch: ["wtype", "á"]
            alt-e:
              launch: ["wtype", "é"]
            alt-i:
              launch: ["wtype", "í"]
            alt-o:
              launch: ["wtype", "ó"]
            alt-u:
              launch: ["wtype", "ú"]
            alt-n:
              launch: ["wtype", "ñ"]
            alt-shift-a:
              launch: ["wtype", "Á"]
            alt-shift-e:
              launch: ["wtype", "É"]
            alt-shift-i:
              launch: ["wtype", "í"]
            alt-shift-o:
              launch: ["wtype", "Ó"]
            alt-shift-u:
              launch: ["wtype", "Ú"]
            alt-shift-n:
              launch: ["wtype", "Ñ"]


        - name: cursor-keyboard
          remap:
            control-shift-alt-up:
              launch: ["ydotool", "mousemove", "-x", "0", "-y", "-5"]
            control-shift-alt-down:
              launch: ["ydotool", "mousemove", "-x", "0", "-y", "5"]
            control-shift-alt-left:
              launch: ["ydotool", "mousemove", "-x", "-5", "-y", "0"]
            control-shift-alt-right:
              launch: ["ydotool", "mousemove", "-x", "5", "-y", "0"]


        modmap:
        - name: others
          remap:
            capslock: enter
      '';
    };
  };
}
