{user, ...}: {
  user-manage = {
    xdg = {
      cacheHome = user.dir.cache;
      configHome = user.dir.config;
      dataHome = user.dir.data;
      stateHome = user.dir.state;

      userDirs = {
        enable = true; # Enable xdg to manage $XDG_CONFIG_HOME/user-dirs.dirs

        createDirectories = true; # Create the directories if not created already

        documents = user.dir.documents;
        download = user.dir.downloads;
        # - Make all media be stored in the same folder
        pictures = user.dir.media;
        videos = user.dir.media;
        music = user.dir.media;

        # - Prevent to be created
        desktop = null;
        publicShare = null;
        templates = null;
      };
    };

    gtk.gtk3.bookmarks = [
      "file://${user.dir.flake}"
      "file://${user.dir.documents}"
      "file://${user.dir.downloads}"
      "file://${user.dir.media}"
      "file://${user.dir.sync}"
    ];
  };
}
