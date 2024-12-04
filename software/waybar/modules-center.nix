{...}: {
  user-manage.programs.waybar.settings.statusBar = {
    modules-center = ["hyprland/workspaces"];

    "hyprland/workspaces" = {
      format = "{windows}";
      format-window-separator = ""; # Empty, for tooltips that used the window-rewrite-default
      window-rewrite-default = "󱔢 ";
      # Other windows rewrite are in files depending of the class of the app, under the alias: waybar-workspace-icon
    };
  };
}
