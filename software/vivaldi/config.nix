{
  pkgs,
  user,
  ...
}: {
  user.manage = {
    programs.chromium = {
      enable = true;

      package = pkgs.vivaldi;
    };

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite = {
      "class<Vivaldi-stable>" = "󰊯 ";
      "class<Brave-browser>" = " ";
    };

    xdg.desktopEntries.vivaldi-rofi = {
      name = "Vivaldi";
      exec = "${pkgs.vivaldi}/bin/vivaldi --enable-features=UseOzonePlatform --ozone-platform=wayland %U"; # Use wayland instead of xwayland
      terminal = false;
      icon = "vivaldi";
      categories = ["X-Rofi" "Network" "WebBrowser"];
    };

    home.packages = with pkgs; [
      brave # Second browser in case primary throws an error
      vdhcoapp # Companion application for the Video DownloadHelper browser add-on.
    ];
  };
}
