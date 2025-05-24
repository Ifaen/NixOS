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
      categories = ["X-Rofi"];
      icon = "kitty";
    };

    hyprland.exec-once = ["[workspace 1 silent] kitty"];
  };
}
