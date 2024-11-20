{pkgs, ...}: {
  user.manage = {
    home.packages = [pkgs.wl-clipboard-rs];

    programs.wezterm = {
      enable = true;

      enableZshIntegration = true;

      extraConfig = ''
        local config = {}

        config.default_prog = { 'zsh' }
        config.font = wezterm.font 'monospace'
        config.window_background_opacity = 0.5
      '';
    };

    xdg.desktopEntries.wezterm-rofi = {
      name = "Wezterm Terminal";
      exec = ''hyprctl dispatch exec "[float;tile] ${pkgs.wezterm}/bin/wezterm start --always-new-process"'';
      categories = ["X-Rofi" "System" "TerminalEmulator" "Utility"];
      icon = "org.wezfurlong.wezterm";
      terminal = false;
    };

    # HACK This is a workaround, until Wezterm has a new release that fixes its bug with hyprland
    wayland.windowManager.hyprland.settings.exec-once = ["[workspace 11 silent;float;tile] wezterm start --always-new-process"];

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite."class<org.wezfurlong.wezterm>" = "󰆍 ";
  };
}
