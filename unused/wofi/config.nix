{user, ...}: {
  user.manage = {
    programs.wofi = {
      enable = true;
    };

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite."class<wofi>" = "󰼢 ";
  };
}
