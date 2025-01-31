{
  pkgs,
  user,
  ...
}: {
  user-manage = {
    programs.firefox = {
      enable = true;

      #profiles.${user.name} = {};
    };

    xdg.desktopEntries.firefox = {
      name = "Firefox";
      exec = "${pkgs.firefox}/bin/firefox --name firefox %U";
      terminal = false;
      icon = "firefox";
      categories = ["X-Rofi" "Network" "WebBrowser"];
      mimeType = [
        "text/html"
        "text/xml"
        "application/xhtml+xml"
        "application/vnd.mozilla.xul+xml"
        "x-scheme-handler/http"
        "x-scheme-handler/https"
      ];
    };
    /*
    hyprland.windowrulev2 = [
      "tile, class:(firefox)"
    ];
    */

    waybar-workspace-icon."class<firefox>" = "󰊯 ";
  };
}
