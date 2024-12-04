{
  config,
  options,
  lib,
  user,
  ...
}: {
  options = {
    user-configuration = lib.mkOption {
      type = options.users.users.type.functor.wrapped;
      default = {};
      description = "User configuration";
    };

    user-manage = lib.mkOption {
      type = options.home-manager.users.type.functor.wrapped;
      default = {};
      description = "Home-manager configuration to be used for the user";
    };
  };

  config = {
    users.users.${user.name} = lib.mkAliasDefinitions options.user-configuration;

    home-manager.users.${user.name} = lib.mkAliasDefinitions options.user-manage;
  };
}
