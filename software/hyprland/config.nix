{
  lib,
  user,
  pkgs,
  ...
}: {
  programs.hyprland.enable = true; # Enable hyprland and install all its dependencies

  # Home-manager configuration
  user-manage = {
    wayland.windowManager.hyprland = {
      enable = true;

      settings =
        {
          cursor.hide_on_key_press = true; # Hide cursor when writing

          gestures.workspace_swipe = "off";

          general = {
            resize_on_border = true;
          };

          input = {
            follow_mouse = 1;
            focus_on_close = true; # When false, focus will shift to the next window candidate. When true, focus will shift to the window under the cursor
            float_switch_override_focus = 2;
            accel_profile = "flat";
          };

          misc = {
            focus_on_activate = true;
            initial_workspace_tracking = 2;
          };
        }
        // lib.optionalAttrs (user.machine == "desktop") {
          monitor = [
            "HDMI-A-1, 1920x1080@60, 0x0, 1"
            "DP-3, 1920x1080@60, 1920x0, 1" # Second monitor to the left
          ];

          workspace = [
            # First monitor
            "1, monitor:HDMI-A-1, default:1"
            "2, monitor:HDMI-A-1"
            "3, monitor:HDMI-A-1"
            "4, monitor:HDMI-A-1"
            "5, monitor:HDMI-A-1"
            "6, monitor:HDMI-A-1"
            "7, monitor:HDMI-A-1"
            "8, monitor:HDMI-A-1"
            "9, monitor:HDMI-A-1"
            "10, monitor:HDMI-A-1"

            # Second monitor
            "11, monitor:DP-3, default:1"
            "12, monitor:DP-3"
            "13, monitor:DP-3"
            "14, monitor:DP-3"
            "15, monitor:DP-3"
            "16, monitor:DP-3"
            "17, monitor:DP-3"
            "18, monitor:DP-3"
            "19, monitor:DP-3"
            "20, monitor:DP-3"
          ];
        };
    };

    # Autostart Hyprland upon a new session shell is initialized in tt1
    programs.zsh.profileExtra = ''
      if [ "$(tty)" = "/dev/tty1" ]; then
        exec Hyprland &>/dev/null
      fi
    '';
  };
}
