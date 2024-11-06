{
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user.name} = {
    programs.obs-studio = {
      enable = true;

      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
    };

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite."class<com.obsproject.Studio>" = "󰄀 "; # nf-md-camera
  };
}
