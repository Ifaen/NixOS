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

    # If the workspace is not the 9 or 10 (Reserved by others)
    if [[ $1 != 9 || $1 != 10 ]]; then
        # Check if workspace is empty
        is_empty=$(hyprctl activeworkspace -j | ${pkgs.jq}/bin/jq '.windows')

        # If empty, open program
        if [ $is_empty == 0 ]; then
        hyprctl dispatch exec "${open-rofi}"
        fi
    fi
  ''}";
in {
  user-manage.hyprland = {
    bind = [
      ## -- Workspaces
      # Change workspace with super + left and right buttons
      "super, left, workspace, e-1"
      "super, right, workspace, e+1"

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

      "super shift, 1, movetoworkspace, 1"
      "super shift, 2, movetoworkspace, 2"
      "super shift, 3, movetoworkspace, 3"
      "super shift, 4, movetoworkspace, 4"
      "super shift, 5, movetoworkspace, 5"
      "super shift, 6, movetoworkspace, 6"
      "super shift, 7, movetoworkspace, 7"
      "super shift, 8, movetoworkspace, 8"
      "super shift, 9, movetoworkspace, 9"
      "super shift, 0, movetoworkspace, 10"

      ## -- Windows
      "super, q, killactive" # Kill active Window
      #"SUPER SHIFT, Q, killwindow" # Enter kill selection mode

      # Change window with super + shift + arrow keys
      "super shift, up, movefocus, u"
      "super shift, down, movefocus, d"
      "super shift, left, movefocus, l"
      "super shift, right, movefocus, r"

      # Move window in the same workspace with super + alt + arrow keys
      "super alt, up, movewindow, u"
      "super alt, down, movewindow, d"
      "super alt, left, movewindow, l"
      "super alt, right, movewindow, r"

      # Change size of window with super + ctrl + arrow keys
      "super control, up, resizeactive, 0 -10"
      "super control, down, resizeactive, 0 10"
      "super control, left, resizeactive, -10 0"
      "super control, right, resizeactive, 10 0"

      # Change state of window # TODO: https://www.reddit.com/r/hyprland/comments/12zesk9/switching_windows_between_monitor_screens/
      "super shift, o, togglesplit"
      "super shift, v, togglefloating"

      ## -- Utilities
      "super, w, exec, pkill rofi || ${open-rofi}"

      # Screenshots
      ", print, exec, ${pkgs.grimblast}/bin/grimblast --freeze --notify copy area"
      "shift, print, exec, ${pkgs.grimblast}/bin/grimblast --freeze --notify copysave area"

      # Change wallpaper with super + up and down buttons
      "super, page_up, exec, ${on-wallpaper-change} up"
      "super, page_down, exec, ${on-wallpaper-change} down"
    ];

    bindm = [
      "SUPER, mouse:272, movewindow" # SUPER + LMB
      "SUPER, mouse:273, resizewindow" # SUPER + RMB
    ];

    input = {
      kb_layout = user.language; # Keyboard layout to be directed to user language
      kb_options = "compose:caps"; # Remap Caps-Lock key to be Compose Key
    };
  };
}
