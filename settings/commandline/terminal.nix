{
  pkgs,
  user,
  ...
}: {
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

  wayland.windowManager.hyprland.settings.exec-once =
    [
      "[workspace 11 silent] wezterm"
    ]
    ++ (
      if user.machine == "desktop"
      then [
        "[workspace 3 silent] wezterm"
      ]
      else []
    );

  programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite."class<org.wezfurlong.wezterm>" = "󰆍";
}
