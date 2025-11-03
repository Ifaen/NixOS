{...}: {
  user-manage.services.hypridle = {
    enable = true;

    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "hyprlock";
      };

      listener = [
        # Lock screen
        {
          timeout = 60 * 5;
          on-timeout = "hyprlock";
        }
        # Turn off the screen
        {
          timeout = 60 * 15;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        # Suspend
        {
          timeout = 60 * 20;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
