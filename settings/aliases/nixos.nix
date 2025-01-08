{
  config,
  options,
  lib,
  user,
  ...
}: {
  options = {
    user-configuration = lib.mkOption {
      type = lib.types.attrsOf lib.types.anything;
      description = "User configuration";
    };

    user-manage = lib.mkOption {
      type = lib.types.attrsOf lib.types.anything;
      description = "Home-manager configuration to be used for the user";
    };
  };

  config = {
    users.users.${user.name} = lib.mkAliasDefinitions options.user-configuration;

    home-manager.users.${user.name} = lib.mkAliasDefinitions options.user-manage;
  };
}
