{...}: {
  user-manage = {
    programs.kitty = {
      enable = true;

      settings = {
        background_opacity = "0.5";
      };
    };

    xdg.desktopEntries."kitty" = {
      name = "Kitty Terminal";
      exec = "kitty";
      categories = ["X-Rofi" "System" "TerminalEmulator"];
      icon = "kitty";
    };

    # HACK Issue with hyprland, probably fixed next patch
    hyprland.exec-once = ["[workspace 3] kitty"];

    waybar-workspace-icon."class<kitty>" = "󰆍 ";
  };
}
