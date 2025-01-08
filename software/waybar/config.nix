# Wiki: https://github.com/Alexays/Waybar/wiki
{
  pkgs,
  user,
  ...
}: {
  user-manage = {
    programs.waybar = {
      enable = true;

      style = ''
        @import "${user.home}/.cache/wal/colors-waybar.css";        /* For the color scheme */
        @import "${user.dir.flake}/software/waybar/style.css";         /* For the styling*/
      '';

      settings.statusBar = {
        layer = "top"; # Contexts menus are on top always
        reload_style_on_change = true;
      };
    };

    xdg.desktopEntries.waybar = {
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
    hyprland.exec-once = ["${pkgs.waybar}/bin/waybar"];
  };
}
