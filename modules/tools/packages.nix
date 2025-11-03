{
  inputs,
  config,
  pkgs,
  unstable-pkgs,
  ...
}: {
  # Adds unstable packages to the system
  _module.args.unstable-pkgs = import inputs.nixpkgs-unstable {
    inherit (pkgs.stdenv.hostPlatform) system;
    inherit (config.nixpkgs) config;
  };

  nixpkgs.config.allowUnfree = true; # Allows unfree packages for nixpkgs

  home-manager = {
    useUserPackages = false; # If true, moves the home-manager packages from $HOME/.nix-profile to /etc/profiles
    useGlobalPkgs = true; # To use the same nixpkgs configuration as the nixos system

    backupFileExtension = "backup";
  };

  user-manage.home.packages = [
    pkgs.gtk3-x11 # Tool to open .desktop files from terminal or commands using gtk-launch
    pkgs.imv # Image viewer
    pkgs.mpv # Video viewer
    pkgs.vlc # Media player
    pkgs.zathura # PDF viewer
    pkgs.pavucontrol # Manage audio sources
    pkgs.libreoffice # Open Source microsoft 365 alternative
    unstable-pkgs.vdhcoapp # Companion application for the Video DownloadHelper browser add-on
  ];

  # Desktop Entries. Simplified and added to Rofi
  user-manage.xdg.desktopEntries = {
    # PavuControl. Audio manager
    pavucontrol = {
      name = "PavuControl";
      exec = "${pkgs.pavucontrol}/bin/pavucontrol";
      icon = "pavucontrol";
      categories = ["X-Rofi"];
    };

    # Discord. Chat client
    vesktop = {
      name = "Discord";
      exec = "${pkgs.vesktop}/bin/vesktop %U";
      icon = "discord";
      categories = ["X-Rofi"];
    };

    # Gimp
    gimp = {
      name = "Gimp";
      exec = "${pkgs.gimp}/bin/gimp %U";
      icon = "gimp";
      mimeType = ["image/bmp" "image/g3fax" "image/gif" "image/x-fits" "image/x-pcx" "image/x-portable-anymap" "image/x-portable-bitmap" "image/x-portable-graymap" "image/x-portable-pixmap" "image/x-psd" "image/x-sgi" "image/x-tga" "image/x-xbitmap" "image/x-xwindowdump" "image/x-xcf" "image/x-compressed-xcf" "image/x-gimp-gbr" "image/x-gimp-pat" "image/x-gimp-gih" "image/x-sun-raster" "image/tiff" "image/jpeg" "image/x-psp" "application/postscript" "image/png" "image/x-icon" "image/x-xpixmap" "image/x-exr" "image/webp" "image/x-webp" "image/heif" "image/heic" "image/avif" "image/jxl" "image/svg+xml" "application/pdf" "image/x-wmf" "image/jp2" "image/x-xcursor"];
      categories = ["X-Rofi"];
    };

    # Obsidian. Knowledge database notes
    obsidian = {
      name = "Obsidian";
      exec = "${pkgs.obsidian}/bin/obsidian %u";
      icon = "obsidian";
      mimeType = ["x-scheme-handler/obsidian"];
      categories = ["X-Rofi"];
    };

    # Spotify. Music player
    # Note: When `libcurl-gnutls.so.4: no version information...` appears, clear Spotify's cache with `rm -rf ~/.cache/spotify`
    spotify = {
      name = "Spotify";
      exec = "env NIXOS_OZONE_WL=1 ${pkgs.spotify}/bin/spotify %U";
      icon = "spotify-client";
      mimeType = ["x-scheme-handler/spotify"];
      settings.StartupWMClass = "spotify";
      categories = ["X-Rofi"];
    };

    # QBitTorrent. Torrent client
    "org.qbittorrent.qBittorrent" = {
      name = "qBittorrent";
      exec = "${pkgs.qbittorrent}/bin/qbittorrent %U";
      icon = "qbittorrent";
      mimeType = ["application/x-bittorrent" "x-scheme-handler/magnet"];
      categories = ["X-Rofi"];
    };
  };

  # Allow management of XDG base directories located on $XDG_DATA_DIRS
  user-manage.xdg.mimeApps.defaultApplications = {
    "image/gif" = "vlc.desktop";
    "application/pdf" = "org.pwmt.zathura.desktop";
  };

  # Hyprland specific settings
  user-manage.hyprland = {
    exec-once = ["[workspace 11 silent] ${pkgs.spotify}/bin/spotify"];
    windowrulev2 = [
      "opacity 0.95, class:(Spotify)"
    ];
  };
}
