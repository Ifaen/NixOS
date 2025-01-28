{pkgs, ...}: {
  user-manage = {
    home.packages = [pkgs.wl-clipboard-rs];

    programs.wezterm = {
      enable = true;

      enableZshIntegration = true;

      extraConfig = ''
        local config = {}

        config.default_prog = { 'zsh' } -- Run zsh on startup
        config.font = wezterm.font 'monospace'
        config.window_background_opacity = 0.5
        config.front_end = "WebGpu"

        config.skip_close_confirmation_for_processes_named = {
          'bash',
          'sh',
          'zsh',
          'lf',
        }
        --config.animation_fps = 60
      '';
    };

    xdg.desktopEntries."org.wezfurlong.wezterm" = {
      name = "Wezterm Terminal";
      exec = ''hyprctl dispatch exec "[float;tile] ${pkgs.wezterm}/bin/wezterm start --always-new-process"'';
      categories = ["X-Rofi" "System" "TerminalEmulator" "Utility"];
      icon = "org.wezfurlong.wezterm";
      terminal = false;
    };

    # HACK Issue with hyprland, probably fixed next patch
    hyprland.exec-once = ["[workspace 3 silent;float;tile] wezterm start --always-new-process"];

    waybar-workspace-icon."class<org.wezfurlong.wezterm>" = "󰆍 ";
  };
}
