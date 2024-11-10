# Wiki: https://github.com/Alexays/Waybar/wiki
{
  pkgs,
  user,
  ...
}: {
  user.manage = {
    programs.waybar = {
      enable = true;

      style = ''
        @import "${user.home}/.cache/wal/colors-waybar.css";        /* For the color scheme */
        @import "${user.flake}/software/waybar/config.css";         /* For the styling*/
        @import "${user.flake}/software/waybar/modules-center.css";
        @import "${user.flake}/software/waybar/modules-left.css";
        @import "${user.flake}/software/waybar/modules-right.css";
      '';

      settings.statusBar = {
        layer = "top"; # Enables that when right clicked or hovered, the context menu is upfront
        reload_style_on_change = true;
      };
    };

    xdg.desktopEntries.waybar-rofi = {
      name = "Waybar";
      exec = "${pkgs.writeShellScript "toggle-waybar" ''
        if pgrep waybar; then
          pkill waybar
        else
          ${pkgs.waybar}/bin/waybar
        fi
      ''}";
      categories = ["X-Rofi"];
      terminal = false;
    };

    # Settings of waybar in other modules
    wayland.windowManager.hyprland.settings.exec-once = ["${pkgs.waybar}/bin/waybar"];
  };
}
