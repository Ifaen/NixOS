{
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user.name}.programs.foot.settings = {
    colors = {
      alpha = "0.5";
      background = "FFFFFF";
    };
  };
}
