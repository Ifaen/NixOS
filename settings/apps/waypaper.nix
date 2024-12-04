{
  pkgs,
  user,
  ...
}: {
  user-manage = {
    home.packages = [
      pkgs.waypaper # GUI for Wallpaper management
      pkgs.swww # Software to change wallpapers, used by waypaper as backend
    ];

    xdg.configFile."waypaper/config.ini".text = ''
      [Settings]
      backend = swww
      color = #ffffff
      fill = Fill
      folder = ${user.dir.wallpapers}
      language = en
      monitors = All
      post_command = ${pkgs.writeShellScript "on-wallpaper-change" ''
        ${pkgs.pywal}/bin/wal -q -n -i $1

        extended-pywal-schemes &

        pkill waypaper
      ''} $wallpaper
      show_hidden = True
      sort = name
      subfolders = False
      swww_transition_angle = 60
      swww_transition_fps = 60
      swww_transition_type = wipe
      swww_transition_duration = 1
    '';

    xdg.desktopEntries.waypaper = {
      name = "Waypaper";
      exec = "${pkgs.waypaper}/bin/waypaper";
      categories = ["X-Rofi" "Utility" "DesktopSettings"];
      terminal = false;
      icon = "waypaper";
    };

    hyprland = {
      exec-once = ["swww-daemon"]; # Start swww daemon

      windowrulev2 = [
        "float, class:(waypaper)"
        "stayfocused, class:(waypaper)"
        "rounding 10, class:(waypaper)"
      ];
    };

    waybar-workspace-icon."class<waypaper>" = " ";
  };
}
