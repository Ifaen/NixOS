{...}: {
  user-manage.programs.hyprpanel.settings = {
    bar.launcher.autoDetectIcon = true; # Show OS icon for launcher

    theme.bar.buttons.style = "default";
    theme.bar.transparent = false;
    theme.bar.opacity = 90;

    # Workspaces
    bar.workspaces.show_icons = false;
    bar.workspaces.showWsIcons = true;
    bar.workspaces.showApplicationIcons = true;
    bar.workspaces.scroll_speed = 1;
    bar.workspaces.spacing = 1.7;
    bar.workspaces.applicationIconMap = {
      "class:vesktop" = "󰙯";
      "class:windsurf" = "󰨞";
      "class:brave-browser" = "󰊯"; # nf-md-google_chrome
      "class:com.github.iwalton3.jellyfin-media-player" = "󰟞"; # nf-md-movie_roll
    };

    bar.workspaces.workspaces = 0;

    # Dashboard
    menus.dashboard.directories.enabled = false;
    menus.dashboard.stats.enable_gpu = false;

    # Notifications
    notifications.timeout = 2000;

    theme.font = {
      name = "FiraCode Nerd Font";
      size = "16px";
    };

    /*
       wallpaper = {
      enable = true;
      pywal = true;
    };
    */
  };
}
