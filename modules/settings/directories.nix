{
  lib,
  user,
  ...
}: {
  user-manage =
    {
      xdg = {
        enable = true; # Whether to enable management of XDG base directories

        cacheHome = user.cache;
        configHome = user.config;
        dataHome = user.data;
        stateHome = user.state;

        userDirs = {
          enable = true; # Enable xdg to manage $XDG_CONFIG_HOME/user-dirs.dirs

          createDirectories = true; # Create the directories if not created already

          download = user.downloads;
          # - Make all media and documents be stored in the same folder
          documents = user.documents;
          pictures = user.documents;
          videos = user.documents;
          music = user.documents;

          extraConfig.XDG_SCREENSHOTS_DIR = user.screenshots; # Variable made and used by Grimblast

          # - Prevent to be created
          desktop = null;
          publicShare = null;
          templates = null;
        };
      };
    }
    // lib.optionalAttrs (user.hostname != "server") {
      gtk.gtk3.bookmarks = [
        "file://${user.flake}"
        "file://${user.documents}"
        "file://${user.downloads}"
        "file://${user.sync}"
      ];
    };
}
