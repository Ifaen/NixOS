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

  workspace-swap = "${pkgs.writeShellScript "workspace-swap" ''
    # 1. Get the two active workspaces
    active_ws=($(hyprctl monitors -j | ${pkgs.jq}/bin/jq '.[] | .activeWorkspace.id'))

    # Check if we have exactly two active workspaces
    if [ "''${#active_ws[@]}" -ne 2 ]; then
      echo "Error: Expected 2 active workspaces, found ''${#active_ws[@]}"
      exit 1
    fi

    ws_a="''${active_ws[0]}"
    ws_b="''${active_ws[1]}"

    # 2. Get all clients with window address, workspace, and class
    clients_json=$(hyprctl clients -j)

    # 3. Move windows from ws_a to ws_b
    echo "$clients_json" | ${pkgs.jq}/bin/jq -r --arg wsa "$ws_a" '.[] | select(.workspace.id == ($wsa | tonumber)) | .address' | while read -r addr; do
      hyprctl dispatch movetoworkspacesilent "$ws_b,address:$addr"
    done

    # 4. Move windows from ws_b to ws_a
    echo "$clients_json" | ${pkgs.jq}/bin/jq -r --arg wsb "$ws_b" '.[] | select(.workspace.id == ($wsb | tonumber)) | .address' | while read -r addr; do
      hyprctl dispatch movetoworkspacesilent "$ws_a,address:$addr"
    done
  ''}";
in {
  user-manage = {
    hyprland = {
      input = {
        kb_layout = "latam"; # Keyboard layout
        kb_options = "compose:caps"; # Remap Caps-Lock key to be Compose Key
        #drag_threshold = 10; # Amount of pixels before drag even triggers TODO: Reenable this when hyprland gets updated
      };

      #bindc = "ALT, mouse:272, togglefloating"; TODO: Reenable this when hyprland gets updated

      bind = [
        "super, s, exec, ${workspace-swap}"

        # Move to numbered workspace within same monitor
        ", F1, workspace, r~1"
        ", F2, workspace, r~2"
        ", F3, workspace, r~3"
        ", F4, workspace, r~4"
        ", F5, workspace, r~5"
        ", F6, workspace, r~6"
        ", F7, workspace, r~7"
        ", F8, workspace, r~8"

        # Move to adjacent workspace within same monitor
        "super, left, workspace, m-1"
        "super, right, workspace, m+1"

        # Move window within same workspace (Also moves to the other monitor)
        "super shift, up, movewindow, u"
        "super shift, down, movewindow, d"
        "super shift, left, movewindow, l"
        "super shift, right, movewindow, r"

        # Move window to numbered workspace within same monitor
        "super, F1, movetoworkspace, r~1"
        "super, F2, movetoworkspace, r~2"
        "super, F3, movetoworkspace, r~3"
        "super, F4, movetoworkspace, r~4"
        "super, F5, movetoworkspace, r~5"
        "super, F6, movetoworkspace, r~6"
        "super, F7, movetoworkspace, r~7"
        "super, F8, movetoworkspace, r~8"

        # Change focus of window (Also changes focus to the other monitor)
        "super alt, up, movefocus, u"
        "super alt, down, movefocus, d"
        "super alt, left, movefocus, l"
        "super alt, right, movefocus, r"

        # Screenshots
        "super shift, s, exec, ${pkgs.grimblast}/bin/grimblast --freeze --notify copy area" # Copy only
        ", print, exec, ${pkgs.grimblast}/bin/grimblast --freeze --notify copysave area" # Copy and save

        # Change wallpaper with super + up and down buttons
        "super, page_up, exec, ${on-wallpaper-change} up"
        "super, page_down, exec, ${on-wallpaper-change} down"

        # MARK: Others
        "super, w, killactive" # Kill active Window
        "super shift, w, killwindow" # Enter kill selection mode
        "super, space, exec, pkill rofi || ${pkgs.rofi}/bin/rofi -show drun -show-icons -drun-categories X-Rofi" # Open Rofi
        ", F11, togglesplit" # Change orientation of window
        ", F12, togglefloating" # Toggle floating attribute of window
      ];

      bindm = [
        "super, mouse:272, movewindow" # SUPER + LMB
        "super, mouse:273, resizewindow" # SUPER + RMB
      ];
    };

    wayland.windowManager.hyprland.extraConfig = ''
      # Window Resize
      bind = super, r, submap, resize
      submap = resize
      binde = , right, resizeactive, 10 0
      binde = , left, resizeactive, -10 0
      binde = , up, resizeactive, 0 -10
      binde = , down, resizeactive, 0 10
      bind = , escape, submap, reset
      submap = reset

      # Move cursor with keys
      #bind = super shift, r, submap, cursor
      #submap = cursor
      # TODO: USE YDOTOOL TO MOVE THE CURSOR WITH THE ARROW KEYS
      #bind = , escape, submap, reset
      #submap = reset
    '';
  };
}
