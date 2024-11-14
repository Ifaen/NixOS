{
  pkgs,
  user,
  ...
}: {
  user.manage = {config, ...}: {
    home.packages = [
      pkgs.waypaper # GUI for Wallpaper management
      pkgs.swww # Software to change wallpapers, used by waypaper as backend
    ];

    # TODO Add to post_command functionality to change hyprland colors too
    xdg.configFile."waypaper/config.ini".text = ''
      [Settings]
      backend = swww
      color = #ffffff
      fill = Fill
      folder = ${config.xdg.userDirs.extraConfig.wallpapers}
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

    wayland.windowManager.hyprland.settings = {
      windowrulev2 = [
        "float, class:(waypaper)"
        "stayfocused, class:(waypaper)"
        "rounding 10, class:(waypaper)"
      ];

      exec-once = ["swww-daemon"]; # Start swww daemon
    };

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite = {
      "class<waypaper>" = " ";
    };
  };
}
