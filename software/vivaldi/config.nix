{pkgs, ...}: {
  user-manage = {
    programs.chromium = {
      enable = true;

      package = pkgs.vivaldi;
    };

    waybar-workspace-icon = {
      "class<Vivaldi-stable>" = "󰊯 ";
      "class<Brave-browser>" = " ";
    };

    xdg.desktopEntries.vivaldi-stable = {
      name = "Vivaldi";
      exec = "${pkgs.vivaldi}/bin/vivaldi %U";
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
