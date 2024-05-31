# Wiki: https://github.com/Alexays/Waybar/wiki
{
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user.name} = {
    programs.waybar.enable = true;

    style = ''
      @import "${user.home}/.cache/wal/colors-waybar.css";        /* For the color scheme */
      @import "${user.flake}/settings/waybar/waybar.style.css";  /* For the styling*/
    '';

    # Settings of waybar in other modules
    wayland.windowManager.hyprland.settings.exec-once = ["waybar"];
  };
}
