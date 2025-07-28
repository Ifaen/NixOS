{
  config,
  lib,
  pkgs,
  ...
}: {
  options.ripdrag.enable = lib.mkEnableOption "Enable RipDrag";

  config = lib.mkIf config.ripdrag.enable {
    user-manage.home.packages = [pkgs.ripdrag];

    user-manage.hyprland.windowrulev2 = [
      "pin, class:(it.catboy.ripdrag)"
    ];
  };
}
