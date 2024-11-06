{user, ...}: let
  media-folder = "${user.home}/Media";
in {
  home-manager.users.${user.name} = {config, ...}: {
    xdg.userDirs = {
      enable = true; # Enable xdg to manage $XDG_CONFIG_HOME/user-dirs.dirs

      createDirectories = true; # Create the directories if not created already

      # Make all media be stored in the same folder
      pictures = media-folder;
      videos = media-folder;
      music = media-folder;

      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${media-folder}/Screenshots";
        recordings = "${media-folder}/Recordings";
        wallpapers = "${media-folder}/Wallpapers";
        sync = "${user.home}/Sync";
        flake = user.flake; # Path were flake is stored
      };

      # Prevent to create
      desktop = null;
      publicShare = null;
      templates = null;
    };

    gtk.gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc"; # Move the gtk config file away from $HOME

    gtk.gtk3.bookmarks = [
      "file://${config.xdg.userDirs.extraConfig.flake}"
      "file://${config.xdg.userDirs.documents}"
      "file://${config.xdg.userDirs.download}"
      "file://${config.xdg.userDirs.pictures}"
      "file://${config.xdg.userDirs.extraConfig.sync}"
    ];
  };
}
