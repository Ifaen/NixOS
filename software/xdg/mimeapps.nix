{pkgs, ...}: {
  # Allow management of XDG base directories
  user.manage = {
    home.packages = with pkgs; [
      imv # Image viewer
      mpv # Video viewer
      zathura # PDF viewer
      vlc # Media player
      libreoffice-fresh # Open Source microsoft 365. Fresh version
    ];

    # To find .desktop files, do "echo $XDG_DATA_DIRS"
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "application/json" = "vscode-rofi.desktop";
        "application/x-httpd-php" = "vscode-rofi.desktop";
        "application/xml" = "vscode-rofi.desktop";

        "application/xhtml+xml" = "vivaldi-rofi.desktop";
        "scheme-handler/http" = "vivaldi-rofi.desktop";
        "scheme-handler/https" = "vivaldi-rofi.desktop";
        "text/html" = "vivaldi-rofi.desktop";
        "x-scheme-handler/http" = "vivaldi-rofi.desktop";
        "x-scheme-handler/https" = "vivaldi-rofi.desktop";

        "image/gif" = "vlc.desktop";
        "application/pdf" = "org.pwmt.zathura.desktop";
      };
    };

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite = {
      "class<libreoffice-calc>" = "󱎏 ";
      "class<org.pwmt.zathura>" = " ";
      "class<vlc>" = "󰕼 "; # nf-md-vlc
      "class<mpv>" = "";
      "class<imv>" = "";
    };
  };
}
