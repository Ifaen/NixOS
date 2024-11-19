{user, ...}: {
  user.manage.xdg.enable = true; # Allow management of XDG base directories

  users.users.${user.name}.extraGroups = ["storage"]; # For disk management in file managers
}
