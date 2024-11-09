{
  pkgs,
  user,
  ...
}: {
  user.manage = {config, ...}: {
    home.packages = [
      pkgs.waypaper # GUI for Wallpaper management
      pkgs.swww # Software to change wallpapers, used by waypar as backend
    ];

    # TODO Add to post_command functionality to change hyprland colors too
    xdg.configFile."waypaper/config.ini".text = ''
      [Settings]
      monitors = All
      show_hidden = True
      subfolders = False
      language = en
      sort = name
      fill = Fill
      color = #ffffff
      folder = ${config.xdg.userDirs.extraConfig.wallpapers}
      post_command = ${pkgs.pywal}/bin/wal -q -i $wallpaper
      backend = swww
      swww_transition_type = any
      swww_transition_step = 90
      swww_transition_angle = 0
      swww_transition_duration = 2
    '';

    wayland.windowManager.hyprland.settings = {
      windowrulev2 = ["float, class:(waypaper)"];

      exec-once = ["swww-daemon"]; # Start swww daemon
    };

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite = {
      "class<waypaper>" = " ";
    };
  };
}
