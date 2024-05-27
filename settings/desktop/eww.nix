{
  pkgs,
  user,
  ...
}: {
  home-manager.users."${user.name}".programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ../../shared/configs/eww;
  };
}
