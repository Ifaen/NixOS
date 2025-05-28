{user, ...}: {
  security.pam.services.hyprlock = {}; # Essential for swaylock to work properly

  user-manage.programs.hyprlock = {
    enable = true;

    settings = {
      source = "${user.cache}/wal/colors-hyprland.conf";

      general = {
        disable_loading_bar = true;
        grace = 10; # Unlock upon mouse movement within 10 seconds after lock
        hide_cursor = true;
        no_fade_in = false;
      };

      background = [{path = "${user.cache}/wal/current-wallpaper";}];

      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb($color5)";
          inner_color = "rgb($color1)";
          outer_color = "rgb($color5)";
          outline_thickness = 5;
          placeholder_text = ''<span foreground="##cad3f5">Password...</span>'';
          shadow_passes = 2;
        }
      ];
    };
  };

  user-manage.hyprland.exec-once = ["hyprlock --immediate --immediate-render --no-fade-in"];
}
