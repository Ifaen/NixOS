{
  config,
  pkgs,
  user,
  ...
}: {
  # File Manager
  programs = {
    partition-manager.enable = false;
  };

  users.users.${user.name}.extraGroups = ["storage"]; # For disk management in file managers

  # Allow management of XDG base directories
  home-manager.users.${user.name} = {
    home.packages = with pkgs; [
      imv # Image viewer
      mpv # Video viewer
      zathura # PDF viewer
      vlc # Media player
      libreoffice-fresh # Open Source microsoft 365. Fresh version
    ];

    xdg.mimeApps = {
      enable = true;
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
      };
      #"application/pdf" = "org.pwmt.zathura.desktop";
    };

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite = {
      "class<libreoffice-calc>" = "󱎏";
      "class<zathura>" = "";
      "class<vlc>" = "󰕼"; # nf-md-vlc
      "class<mpv>" = "";
      "class<imv>" = "";
      "class<org.kde.partitionmanager>" = "󰋊"; # nf-md-harddisk
    };
  };
}
