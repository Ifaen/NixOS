{
  options,
  lib,
  user,
  ...
}: {
  options = {
    user-manage = lib.mkOption {
      type = lib.types.attrsOf lib.types.anything;
      description = "Home-manager configuration to be used for the user";
    };
  };

  config = {
    home-manager.users.${user.name} = lib.mkAliasDefinitions options.user-manage;
  };
}
