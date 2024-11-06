{user, ...}: {
  # File Manager
  programs.partition-manager.enable = false;

  users.users.${user.name}.extraGroups = ["storage"]; # For disk management in file managers

  home-manager.users.${user.name}.xdg.enable = true; # Allow management of XDG base directories
}
