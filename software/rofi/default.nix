{
  lib,
  user,
  pkgs,
  ...
}: {
  user-manage = {
    programs.rofi = {
      enable = true;

      package = pkgs.rofi-wayland;

      terminal = "${pkgs.foot}/bin/foot";

      theme = lib.mkForce "${user.flake}/software/rofi/style.rasi";

      extraConfig = {
        show-icons = true;

        drun-categories = "X-Rofi";
      };
    };

    hyprland.windowrulev2 = map (rule: rule + ", class:(Rofi)") [
      "float"
      "pin"
    ];
  };
}
