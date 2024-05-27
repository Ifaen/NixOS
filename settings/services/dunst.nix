{user, ...}: {
  home-manager.users.${user.name} = {
    services.dunst = {
      enable = true;
    };
  };
}
