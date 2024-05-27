{
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user.name} = {
    programs.wezterm = {
      enable = true;

      enableZshIntegration = true;

      extraConfig = ''
        local wezterm = require 'wezterm'
        local config = {}
        config.default_prog = { 'zsh' }
        config.font = wezterm.font 'monospace'
        config.window_background_opacity = 0.5

        return config
      '';
    };

    wayland.windowManager.hyprland.settings.exec-once = ["[workspace 11 silent;float;tile] wezterm start --always-new-process"]; # FIXME This is a workaround, until Wezterm has a new release that fixes its bug

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite."class<org.wezfurlong.wezterm>" = "󰆍";
  };
}
