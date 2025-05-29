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
        "application/json" = "code.desktop";
        "application/x-httpd-php" = "code.desktop";
        "application/xml" = "code.desktop";

        "application/xhtml+xml" = "firefox.desktop";
        "scheme-handler/http" = "firefox.desktop";
        "scheme-handler/https" = "firefox.desktop";
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";

        "image/gif" = "vlc.desktop";
        "application/pdf" = "org.pwmt.zathura.desktop";
      };
    };
  };
}
