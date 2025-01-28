{pkgs, ...}: {
  user-manage = {
    programs.chromium = {
      enable = true;

      package = pkgs.vivaldi;
    };

    # Companion application for the Video DownloadHelper browser add-on.
    home.packages = with pkgs; [vdhcoapp];

    xdg.desktopEntries.vivaldi-stable = {
      name = "Vivaldi";
      exec = "${pkgs.vivaldi}/bin/vivaldi %U";
      terminal = false;
      icon = "vivaldi";
      categories = ["X-Rofi" "Network" "WebBrowser"];
    };

    hyprland.windowrulev2 = [
      "tile, class:(Vivaldi-stable)"
    ];

    waybar-workspace-icon = {
      "class<Vivaldi-stable>" = "󰊯 ";
      "class<Brave-browser>" = " ";
    };
  };
}
