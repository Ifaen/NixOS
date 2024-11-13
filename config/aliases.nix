{
  config,
  options,
  lib,
  user,
  ...
}: {
  options = {
    user.manage = lib.mkOption {
      type = options.home-manager.users.type.functor.wrapped;
      default = {}; # Empty on purpose
      description = "Home-manager configuration to be used for the user";
    };
  };

  config = {
    home-manager.users.${user.name} = lib.mkAliasDefinitions options.user.manage; # Make user.manage to be an alias of home-manager.users.${user.name}
  };
}
