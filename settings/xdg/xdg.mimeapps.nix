{
  config,
  pkgs,
  user,
  ...
}: {
  # Allow management of XDG base directories
  home-manager.users.${user.name} = {
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
        "application/json" = "code.desktop";
        "application/x-httpd-php" = "code.desktop";
        "application/xml" = "code.desktop";

        "application/xhtml+xml" = "vivaldi-stable.desktop";
        "scheme-handler/http" = "vivaldi-stable.desktop";
        "scheme-handler/https" = "vivaldi-stable.desktop";
        "text/html" = "vivaldi-stable.desktop";
        "x-scheme-handler/http" = "vivaldi-stable.desktop";
        "x-scheme-handler/https" = "vivaldi-stable.desktop";

        "image/gif" = "vlc.desktop";
      };
      #"application/pdf" = "org.pwmt.zathura.desktop";
    };

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite = {
      "class<libreoffice-calc>" = "󱎏 ";
      "class<zathura>" = " ";
      "class<vlc>" = "󰕼 "; # nf-md-vlc
      "class<mpv>" = "";
      "class<imv>" = "";
      "class<org.kde.partitionmanager>" = "󰋊 "; # nf-md-harddisk
    };
  };
}
