{
  pkgs,
  user,
  ...
}: {
  programs.hyprland.enable = true; # Windows Manager.

  # Configuration of window manager
  home-manager.users.${user.name}.wayland.windowManager.hyprland = {
    enable = true;
    # SETTINGS
    settings = {
      source = "${user.home}/.cache/wal/colors-hyprland.conf"; # Obtain color scheme from pywal

      animations = {
        enabled = "yes";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      decoration = {
        rounding = 0;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };

        drop_shadow = "yes";
        shadow_range = 300;
        shadow_render_power = 4;
        shadow_offset = "0 40";
        shadow_scale = 0.9;
        "col.shadow" = "rgba($color0ee)";
      };

      general = {
        border_size = 4;
        "col.active_border" = "rgba($color6a1)";
        "col.inactive_border" = "rgba($color1aa)";

        gaps_in = 2;
        gaps_out = 2;

        layout = "master";
      };

      gestures.workspace_swipe = "off";

      input =
        {
          follow_mouse = 1;
        }
        // (
          if user.machine == "desktop"
          then {
            sensitivity = 1; # range [-1.0, 1.0], 0 means no modification.
          }
          else {
            sensitivity = 0;

            touchpad = {
              natural_scroll = "no";
              disable_while_typing = false;
            };
          }
        );

      #master.new_is_master = false;

      misc.disable_hyprland_logo = true;

      monitor =
        if user.machine == "notebook"
        then "${user.monitor},1920x1200, auto, 1"
        else [
          "${user.monitor}, highres, 1920x0, 1"
          "${user.monitor2}, highres, 0x0, 1"
        ];

      workspace =
        if user.machine == "desktop" # When second monitor is turn off, workspaces move to default monitor
        then [
          "1, monitor:${user.monitor}, default:true"
          "2, monitor:${user.monitor}"
          "3, monitor:${user.monitor}"
          "4, monitor:${user.monitor}"
          "5, monitor:${user.monitor}"
          # Workspaces 5 to 10 are to move workspaces 1 to 5 between monitors
          "6, monitor:${user.monitor2}"
          "7, monitor:${user.monitor2}"
          "8, monitor:${user.monitor2}"
          "9, monitor:${user.monitor2}"
          "10, monitor:${user.monitor2}"
          # Workspaces with specific softwares
          "11, monitor:${user.monitor2}, default:true"
          "12, monitor:${user.monitor2}"
          "13, monitor:${user.monitor2}, on-created-empty:keepassxc"
          "14, monitor:${user.monitor2}"
        ]
        else [];
    };
  };
}
