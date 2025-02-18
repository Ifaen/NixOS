{
  lib,
  pkgs,
  user,
  ...
}: {
  user-manage =
    {
      programs.firefox = {
        enable = true; # Install firefox
        profiles.${user.name} = {
          id = 0;
          isDefault = true;
        };
      };

      # Create an entry for Rofi
      xdg.desktopEntries.firefox = {
        name = "Firefox";
        exec = "firefox --name firefox %U";
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
    }
    // lib.optionalAttrs (user.machine != "wsl") {
      waybar-workspace-icon."class<firefox>" = "󰈹 "; # Icon
    };
}
