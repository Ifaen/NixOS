{user, ...}: {
  user-manage = {
    xdg = {
      cacheHome = user.cache;
      configHome = user.config;
      dataHome = user.data;
      stateHome = user.state;

      userDirs = {
        enable = true; # Enable xdg to manage $XDG_CONFIG_HOME/user-dirs.dirs

        createDirectories = true; # Create the directories if not created already

        documents = user.documents;
        download = user.downloads;
        # - Make all media be stored in the same folder
        pictures = user.media;
        videos = user.media;
        music = user.media;

        extraConfig.XDG_SCREENSHOTS_DIR = user.screenshots; # Used by Grimblast

        # - Prevent to be created
        desktop = null;
        publicShare = null;
        templates = null;
      };
    };

    gtk.gtk3.bookmarks = [
      "file://${user.flake}"
      "file://${user.documents}"
      "file://${user.downloads}"
      "file://${user.media}"
      "file://${user.sync}"
    ];
  };
}
