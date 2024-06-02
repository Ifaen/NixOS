{user, ...}: {
  home-manager.users.${user.name}.xdg.userDirs = {
    createDirectories = true; # Allow management of XDG base directories

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
}
