{
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user.name}.programs.foot.settings = {
    colors.background = "FFFFFFaa";
    mouse.hide-when-typing = "yes";
  };
}
