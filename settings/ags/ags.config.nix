{
  user,
  ags,
  ...
}: {
  home-manager.users.${user.name} = {
    imports = [ags.homeManagerModules.default];

    programs.ags = {
      enable = true;
      configDir = ./.;
    };
  };
}
