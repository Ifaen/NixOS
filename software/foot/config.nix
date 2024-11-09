{
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user.name} = {
    programs.foot = {
      enable = true;
      server.enable = false;
    };

    xdg.desktopEntries.foot-rofi = {
      name = "Foot Terminal";
      exec = "${pkgs.foot}/bin/foot %U";
      terminal = false;
      icon = "foot";
      categories = ["X-Rofi" "System" "TerminalEmulator"];
    };

    wayland.windowManager.hyprland.settings.exec-once = ["[workspace 11 silent] foot"];

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite."class<foot>" = "󰆍 ";
  };
}
