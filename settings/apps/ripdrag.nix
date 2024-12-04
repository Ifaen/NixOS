{...}: {
  user.manage = {
    wayland.windowManager.hyprland.settings.windowrulev2 = ["pin, class:(it.catboy.ripdrag)"];

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite."class<it.catboy.ripdrag>" = "󰩬 ";
  };
}
