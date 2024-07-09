{user, ...}: {
  home-manager.users.${user.name} = {
    programs.thunderbird = {
      enable = true;

      profiles.${user.name} = {
        isDefault = true;
      };
    };

    wayland.windowManager.hyprland.settings.exec-once = ["[workspace 14 silent] thunderbird"];

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite."class<thunderbird>" = "󱗆"; # nf-md-bird
  };
}
