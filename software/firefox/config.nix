{
  pkgs,
  user,
  ...
}: {
  user-manage = {
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
      icon = "firefox";
      categories = ["X-Rofi"];
      mimeType = ["text/html" "text/xml" "application/xhtml+xml" "application/vnd.mozilla.xul+xml" "x-scheme-handler/http" "x-scheme-handler/https"];
    };

    hyprland.windowrulev2 = map (rule: rule + ", title:(Picture-in-Picture)") [
      "center 1"
      "float"
      "pin" # Show in all workspaces. Float only
      "noinitialfocus"
      "size 30% 30%"
    ];
  };
}
