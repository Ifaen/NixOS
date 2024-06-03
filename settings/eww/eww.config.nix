{
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user.name}.programs.eww = {
    enable = true;
    configDir = ./.;
  };
}
