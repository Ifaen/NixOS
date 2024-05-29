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

  environment.systemPackages = with pkgs; [
    imv # Image viewer
    gimp # Image editor
    vlc # Media player
    zathura # PDF viewer
    libreoffice-fresh # Open Source microsoft 365. Fresh version
  ];

  # Allow management of XDG base directories
  home-manager.users.${user.name} = {
    xdg = {
      enable = true;

      mimeApps = {
        enable = true;
        defaultApplications = {
          "text/csv" = "calc.destkop";
          "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = "calc.desktop";

          "application/json" = "code.desktop";
          "application/x-httpd-php" = "code.desktop";
          "application/xml" = "code.desktop";
          "text/css" = "code.desktop";
          "text/plain" = "code.desktop";
          "text/x-shellscript" = "code.desktop";
          "text/xml" = "code.desktop";

          "image/jpeg" = "imv.desktop gimp.desktop";
          "image/jpg" = "imv.desktop gimp.desktop";
          "image/png" = "imv.desktop gimp.desktop";
          "image/svg+xml" = "imv.desktop gimp.desktop";

          "application/xhtml+xml" = "librewolf.desktop";
          "scheme-handler/http" = "librewolf.desktop";
          "scheme-handler/https" = "librewolf.desktop";
          "text/html" = "librewolf.desktop";
          "x-scheme-handler/http" = "librewolf.desktop";
          "x-scheme-handler/https" = "librewolf.desktop";

          "image/gif" = "vlc.desktop";

          "application/pdf" = "org.pwmt.zathura.desktop";

          "x-scheme-handler/tg" = "userapp-Telegram Desktop-4V96K2.desktop";
        };
      };

      userDirs = {
        createDirectories = true;

        pictures = "${user.home}/Media";
        videos = "${user.home}/Media";
        music = "${user.home}/Media";

        extraConfig = {
          sync = "${user.home}/Sync";
          flake = user.flake; # Path were flake is stored
        };

        # Prevent to create
        desktop = null;
        publicShare = null;
        templates = null;
      };
    };

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite = {
      "class<libreoffice-calc>" = "󱎏";
      "class<zathura>" = "";
      "class<vlc>" = "󰕼"; # nf-md-vlc
      "class<org.kde.partitionmanager>" = "󰋊"; # nf-md-harddisk
    };
  };
}
