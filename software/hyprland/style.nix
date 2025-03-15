{user, ...}: {
  user-manage.hyprland = {
    source = "${user.cache}/wal/colors-hyprland.conf"; # Obtain color scheme from pywal

    windowrulev2 = [
      "suppressevent maximize, class:(.*)" # Prevent maximize event
      "rounding 10, floating:1" # Rounding for all floating windows
    ];

    animations = {
      enabled = true;
      first_launch_animation = true;
    };

    decoration = {
      rounding = 0;
      active_opacity = 1.0;
      inactive_opacity = 1.0;
      fullscreen_opacity = 1.0;

      blur = {
        enabled = true;
        size = 3;
        passes = 1;
      };

      shadow = {
        enabled = true;
        range = 4;
        ignore_window = true;
      };
    };

    general = {
      border_size = 4;

      gaps_in = 2;
      gaps_out = 2;
    };

    general.layout = "dwindle";
    dwindle = {
      preserve_split = true; # If enabled, the split (side/top) will not change regardless of what happens to the container
    };

    misc.disable_hyprland_logo = true;
  };
}
