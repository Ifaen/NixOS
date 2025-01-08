{pkgs, ...}: {
  # Allow management of XDG base directories
  user-manage = {
    home.packages = with pkgs; [
      imv # Image viewer
      mpv # Video viewer
      vlc # Media player
      zathura # PDF viewer
      libreoffice # Open Source microsoft 365 alternative
    ];

    xdg.mimeApps = {
      enable = true;

      # To find .desktop files, do "echo $XDG_DATA_DIRS"
      defaultApplications = {
        "application/json" = "vscode.desktop";
        "application/x-httpd-php" = "vscode.desktop";
        "application/xml" = "vscode.desktop";

        "application/xhtml+xml" = "vivaldi.desktop";
        "scheme-handler/http" = "vivaldi.desktop";
        "scheme-handler/https" = "vivaldi.desktop";
        "text/html" = "vivaldi.desktop";
        "x-scheme-handler/http" = "vivaldi.desktop";
        "x-scheme-handler/https" = "vivaldi.desktop";

        "image/gif" = "vlc.desktop";
        "application/pdf" = "org.pwmt.zathura.desktop";
      };
    };

    waybar-workspace-icon = {
      "imv" = "";
      "mpv" = "";
      "org.pwmt.zathura" = " ";
      "vlc" = "󰕼 "; # nf-md-vlc
    };
  };
}
