{...}: {
  user.manage = {
    services.mako = {
      enable = true;
      defaultTimeout = 5 * 1000;
    };
  };
}
