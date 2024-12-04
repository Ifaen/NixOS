{user, ...}: {
  user-manage.xdg.enable = true; # Allow management of XDG base directories

  user-configuration.extraGroups = ["storage"]; # For disk management in file managers
}
