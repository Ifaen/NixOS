{
  config,
  pkgs,
  user,
  ...
}: {
  # File Manager
  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
        thunar-media-tags-plugin
      ];
    };
    partition-manager.enable = true;
    xfconf.enable = true;
  };

  users.users.${user.name}.extraGroups = ["storage"]; # For disk management in file managers

  environment.systemPackages = with pkgs; [
    vlc # Media player
    zathura # For pdf
    libreoffice-fresh # For excel files
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
          "image/webp" = "librewolf.desktop";

          "inode/directory" = "lf.desktop vlc.desktop";

          "image/gif" = "vlc.desktop";
          "video/3gpp" = "vlc.desktop";
          "video/mp2t" = "vlc.desktop";
          "video/mp4" = "vlc.desktop";
          "video/mpeg" = "vlc.desktop";
          "video/webm" = "vlc.desktop";

          "application/pdf" = "org.pwmt.zathura.desktop";

          "x-scheme-handler/tg" = "userapp-Telegram Desktop-4V96K2.desktop";

          #"application/vnd.microsoft.portable-executable" = "wine.desktop"; # Open .exe windows apps with wine

          #"application/x-7z-compressed" = ; TODO for .7z files
          #"audio/3gpp2" = ; TODO for .3g2 files
          #"application/msword" = ""; # TODO for .doc files
          #"application/vnd.openxmlformats-officedocument.wordprocessingml.document" = ""; # TODO for .docx files
          #"image/vnd.microsoft.icon" = ""; TODO For .ico files
          #"audio/webm" = ""; TODO for .weba files
          #"application/vnd.ms-powerpoint" = ""; # TODO for .ppt files
          #"audio/mpeg" = ""; find proper for .mp3 files
          #"application/vnd.openxmlformats-officedocument.presentationml.presentation" = ""; TODO for .pptx files
          #"application/vnd.rar" = ""; TODO find for .rar files
          #"application/x-tar" = ""; TODO for .tar files
          #"application/zip" = ""; TODO for .zip  files
        };
      };

      userDirs = {
        createDirectories = true;
        pictures = "${user.home}/Media";
        videos = "${user.home}/Media";
        extraConfig = {
          XDG_SYNC = "${user.home}/Sync";
        };
        # Prevent to create
        music = null;
        desktop = null;
        publicShare = null;
        templates = null;
      };
    };

    # Open an instance of ranger in alacritty
    home.file.lf = {
      enable = true;
      target = "${user.home}/.local/share/applications/lf.desktop";
      text = ''
        [Desktop Entry]
        Type=Application
        Name=lf
        Comment=Launches the ranger file manager
        Icon=utilities-terminal
        Terminal=false
        Exec=alacritty -e ranger
        Categories=ConsoleOnly;System;FileTools;FileManager
        MimeType=inode/directory;
        Keywords=File;Manager;Browser;Explorer;Launcher;Vi;Vim;Python
      '';
    };

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite = {
      "class<thunar>" = "";
      "class<libreoffice-calc>" = "󱎏";
      "class<zathura>" = "";
      "class<org.kde.partitionmanager>" = "󰋊"; # nf-md-harddisk
    };
  };
}
