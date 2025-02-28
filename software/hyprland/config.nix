{
  lib,
  user,
  ...
}: {
  programs.hyprland.enable = true; # Enable hyprland and install all its dependencies

  # Home-manager configuration
  user-manage.wayland.windowManager.hyprland = {
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
          focus_on_close = true; # When set to 0, focus will shift to the next window candidate. When set to 1, focus will shift to the window under the cursor
          float_switch_override_focus = 2;
          accel_profile = "flat"; # Also useful for ydotool for consistency with `mousemove` command
        };

        misc.focus_on_activate = true;
      }
      // lib.optionalAttrs (user.machine == "desktop") {
        monitor = [
          "HDMI-A-1, 1920x1080@74.97, 0x0, 1"
          "DP-3, 1920x1080@60, 1920x0, 1"
        ];
      };
  };
}
