{
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user.name} = {
    programs.foot = {
      enable = true;
    };

    wayland.windowManager.hyprland.settings.exec-once = ["[workspace 11 silent] foot"];

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite."class<org.wezfurlong.wezterm>" = "󰆍";
  };
}
