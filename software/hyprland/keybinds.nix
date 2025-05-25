{
  pkgs,
  user,
  ...
}: let
  # Change the wallpaper with specific parameters. ACCEPTED FILE TYPES: jpg | jpeg | png | gif | pnm | tga | tiff | webp | bmp | farbfeld
  on-wallpaper-change = "${pkgs.writeShellScript "on-wallpaper-change" ''
    current_wallpaper=$(basename $(${pkgs.swww}/bin/swww query | head -n 1 | awk -F 'image: ' '{print $2}'))

    directory_wallpaper=${user.wallpapers}

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

    ${pkgs.waypaper}/bin/waypaper --wallpaper $directory_wallpaper/$new_wallpaper

    cp $directory_wallpaper/$new_wallpaper ~/.cache/wal/current-wallpaper

    ${pkgs.libnotify}/bin/notify-send "Colors and Wallpaper updated" "with image: $new_wallpaper"
  ''}";

  open-rofi = "${pkgs.rofi}/bin/rofi -show drun -show-icons -drun-categories X-Rofi";

  workspace-change = "${pkgs.writeShellScript "workspace-change" ''
    # Kill every instance, in case there was one
    pkill rofi

    # Move to numbered workspace within the same monitor
    hyprctl dispatch workspace r~$1

    # Check if workspace is empty
    is_empty=$(hyprctl activeworkspace -j | ${pkgs.jq}/bin/jq '.windows')

    # If empty, open program
    if [ $is_empty == 0 ]; then
      hyprctl dispatch exec "${open-rofi}"
    fi
  ''}";
in {
  user-manage.hyprland = {
    input = {
      kb_layout = "latam"; # Keyboard layout
      kb_options = "compose:caps"; # Remap Caps-Lock key to be Compose Key
      #drag_threshold = 10; # Amount of pixels before drag even triggers TODO: Reenable this when hyprland gets updated
    };

    #bindc = "ALT, mouse:272, togglefloating"; TODO: Reenable this when hyprland gets updated

    bind = [
      # MARK: Workspaces and Windows
      # Move to another workspace within same monitor
      "super, left, workspace, m-1"
      "super, right, workspace, m+1"

      # Move to numbered workspace within same monitor
      "super, 1, exec, ${workspace-change} 1"
      "super, 2, exec, ${workspace-change} 2"
      "super, 3, exec, ${workspace-change} 3"
      "super, 4, exec, ${workspace-change} 4"
      "super, 5, exec, ${workspace-change} 5"
      "super, 6, exec, ${workspace-change} 6"
      "super, 7, exec, ${workspace-change} 7"
      "super, 8, exec, ${workspace-change} 8"
      "super, 9, exec, ${workspace-change} 9"
      "super, 0, exec, ${workspace-change} 10"

      # Move window within same workspace (Also moves to the other monitor)
      "super shift, up, movewindow, u"
      "super shift, down, movewindow, d"
      "super shift, left, movewindow, l"
      "super shift, right, movewindow, r"

      # Move window to numbered workspace within same monitor
      "super shift, 1, movetoworkspace, r~1"
      "super shift, 2, movetoworkspace, r~2"
      "super shift, 3, movetoworkspace, r~3"
      "super shift, 4, movetoworkspace, r~4"
      "super shift, 5, movetoworkspace, r~5"
      "super shift, 6, movetoworkspace, r~6"
      "super shift, 7, movetoworkspace, r~7"
      "super shift, 8, movetoworkspace, r~8"
      "super shift, 9, movetoworkspace, r~9"
      "super shift, 0, movetoworkspace, r~10"

      # Change focus of window (Also changes focus to the other monitor)
      "super alt, up, movefocus, u"
      "super alt, down, movefocus, d"
      "super alt, left, movefocus, l"
      "super alt, right, movefocus, r"

      # Resize active window (If there's more than one window in the workspace)
      "super control, up, resizeactive, 0 -10"
      "super control, down, resizeactive, 0 10"
      "super control, left, resizeactive, -10 0"
      "super control, right, resizeactive, 10 0"

      # Screenshots
      "super, s, exec, ${pkgs.grimblast}/bin/grimblast --freeze --notify copy area" # Copy only
      ", print, exec, ${pkgs.grimblast}/bin/grimblast --freeze --notify copysave area" # Copy and save

      # Change wallpaper with super + up and down buttons
      "super, page_up, exec, ${on-wallpaper-change} up"
      "super, page_down, exec, ${on-wallpaper-change} down"

      # MARK: Others
      "super, q, killactive" # Kill active Window
      #"SUPER SHIFT, Q, killwindow" # Enter kill selection mode
      "super, w, exec, pkill rofi || ${open-rofi}" # Open Rofi
      "super, o, togglesplit" # Change orientation of window
      "super, v, togglefloating" # Toggle floating attribute of window
    ];

    bindm = [
      "super, mouse:272, movewindow" # SUPER + LMB
      "super, mouse:273, resizewindow" # SUPER + RMB
    ];
  };
}
