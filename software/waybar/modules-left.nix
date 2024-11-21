{pkgs, ...}: let
  move-cursor-to-center = "${pkgs.writeShellScript "move-cursor-to-center" ''
    # Set target screen center (assuming 1920x1080 screen resolution)
    target_x=$((1920 / 2))
    target_y=$((1080 / 2))

    # Get current cursor position as JSON
    coords=$(hyprctl cursorpos -j)

    # Parse the x and y values
    current_x=$(echo "$coords" | ${pkgs.jq}/bin/jq '.x')
    current_y=$(echo "$coords" | ${pkgs.jq}/bin/jq '.y')

    # Calculate offsets needed to center cursor, adjusted for ydotool doubling
    move_x=$((target_x - current_x))
    move_y=$((target_y - current_y))

    # Move the cursor
    ydotool mousemove -- "$move_x" "$move_y"
  ''}";
in {
  user.manage.programs.waybar.settings.statusBar = {
    modules-left = [
      "custom/power"
      "custom/app-launcher"
      "custom/wallpaper-launcher"
      "custom/vpn"
      "idle_inhibitor"
    ];

    "custom/power" = {
      format = "";
      tooltip = false;
      on-click = "wlogout & ${move-cursor-to-center}";
    };

    "custom/app-launcher" = {
      format = "󱄅";
      tooltip = false;
      on-click = "${pkgs.writeShellScript "toggle-rofi" ''
        if pgrep rofi; then
          pkill rofi
        else
          ${move-cursor-to-center}

          # If rofi is not running, start it
          hyprctl dispatch exec "${pkgs.rofi}/bin/rofi -show drun -show-icons -drun-categories 'X-Rofi'"
        fi
      ''}";
    };

    "custom/wallpaper-launcher" = {
      format = "";
      tooltip = false;
      on-click = "${pkgs.writeShellScript "toggle-waypaper" ''
        if pgrep waypaper; then
          pkill waypaper
        else
          ${move-cursor-to-center}

          hyprctl dispatch exec ${pkgs.waypaper}/bin/waypaper
        fi
      ''}";
    };

    "custom/vpn" = {
      format = "󰖂";
      tooltip = false;
      on-click = "${pkgs.writeShellScript "toggle-vpn" ''
        ${move-cursor-to-center}

        SERVICE_NAME="openvpn-protonvpn.service"

        VPN_STATUS=$(systemctl is-active $SERVICE_NAME) # Check if is active

        if [ "$VPN_STATUS" == "active" ]; then
          systemctl stop $SERVICE_NAME # without sudo, so polkit is prompted
          ${pkgs.libnotify}/bin/notify-send "VPN Stopped"
        else
          systemctl start $SERVICE_NAME
          ${pkgs.libnotify}/bin/notify-send "VPN Started"
        fi
      ''}";
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
