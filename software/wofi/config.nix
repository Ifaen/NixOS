{user, ...}: {
  home-manager.users.${user.name} = {
    programs.wofi = {
      enable = true;
    };

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite."class<wofi>" = "󰼢 ";
  };
}
