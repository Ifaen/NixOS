{pkgs, ...}: {
  user-manage = {
    programs.chromium = {
      enable = true;

      package = pkgs.vivaldi;
    };

    xdg.desktopEntries.vivaldi-stable = {
      name = "Vivaldi";
      exec = "vivaldi %U";
      terminal = false;
      icon = "vivaldi";
      categories = ["X-Rofi" "Network" "WebBrowser"];
    };

    hyprland.windowrulev2 = [
      "tile, class:(Vivaldi-stable)"
    ];

    waybar-workspace-icon."class<Vivaldi-stable>" = "󰊯 ";
  };
}
