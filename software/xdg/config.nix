{user, ...}: {
  # File Manager
  programs.partition-manager.enable = false;

  users.users.${user.name}.extraGroups = ["storage"]; # For disk management in file managers

  user.manage.xdg.enable = true; # Allow management of XDG base directories
}
