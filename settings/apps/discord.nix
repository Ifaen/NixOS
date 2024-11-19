{
  pkgs,
  user,
  ...
}: {
  user.manage = {
    home.packages = [pkgs.vesktop];

    xdg.desktopEntries.discord-rofi = {
      name = "Vesktop";
      exec = "${pkgs.vesktop}/bin/vesktop %U";
      terminal = false;
      icon = "discord";
      categories = ["X-Rofi" "Network" "InstantMessaging"];
    };

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite."class<de.shorsh.discord-screenaudio>" = " ";
  };
}
