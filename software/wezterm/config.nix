{
  lib,
  pkgs,
  user,
  ...
}: {
  user-manage =
    {
      home.packages = [pkgs.wl-clipboard-rs];

      programs.wezterm = {
        enable = true;

        enableZshIntegration = true;

        extraConfig = ''
          local config = {}

          ${
            if (user.machine == "wsl")
            then ''
              config.window_background_opacity = 0.9
              --config.default_domain = 'WSL:NixOS'
            ''
            else ''
              config.font = wezterm.font 'monospace'
              config.window_background_opacity = 0.5
              config.animation_fps = 60
              config.front_end = "WebGpu"
            ''
          }

          config.default_prog = { 'zsh' } -- Run zsh on startup

          config.skip_close_confirmation_for_processes_named = {
            'bash',
            'sh',
            'zsh',
            'lf',
          }
        '';
      };
    }
    // lib.optionalAttrs (user.machine != "wsl") {
      xdg.desktopEntries."org.wezfurlong.wezterm" = {
        name = "Wezterm Terminal";
        exec = ''hyprctl dispatch exec "[float;tile] wezterm start --always-new-process"''; # HACK Issue with hyprland, probably fixed next patch
        categories = ["X-Rofi" "System" "TerminalEmulator" "Utility"];
        icon = "org.wezfurlong.wezterm";
        terminal = false;
      };

      # HACK Issue with hyprland, probably fixed next patch
      hyprland.exec-once = ["[workspace 3 silent;float;tile] wezterm start --always-new-process"];

      waybar-workspace-icon."class<org.wezfurlong.wezterm>" = "󰆍 ";
    };
}
