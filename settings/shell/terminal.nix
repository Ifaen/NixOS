{
  pkgs,
  user,
  ...
}: {
  programs.wezterm = {
    enable = true;
  };

  programs.foot = {
    enable = true;
  };

  programs.kitty = {
    enable = true;

    settings = {
      enable_audio_bell = false;
      background_opacity = "0.5";
      shell = "${pkgs.zsh}/bin/zsh"; # Default terminal
      window_padding_width = 10;
      window_margin_width = "0 0 50";
      font_size = 14;
    };

    keybindings = {
      "ctrl+c" = "copy_or_interrupt"; # Copy when text is selected
    };

    shellIntegration.enableZshIntegration = true;
  };

  wayland.windowManager.hyprland.settings.exec-once =
    [
      "[workspace 11 silent] kitty"
    ]
    ++ (
      if user.machine == "desktop"
      then [
        "[workspace 3 silent] kitty"
      ]
      else []
    );

  programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite."class<kitty>" = "󰆍";
}
