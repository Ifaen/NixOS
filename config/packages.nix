{pkgs, ...}: {
  user.manage = {
    # -- Packages
    home.packages = [
      pkgs.file
      pkgs.telegram-desktop # groups
    ];

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite."class<org.telegram.desktop>" = " ";
  };
}
