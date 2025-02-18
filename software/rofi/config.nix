{
  lib,
  pkgs,
  user,
  ...
}: {
  user-manage =
    {
      programs.rofi = {
        enable = true;

        package = pkgs.rofi-wayland;

        terminal = "${pkgs.wezterm}/bin/wezterm";

        extraConfig = {
          show-icons = true;

          drun-categories = "X-Rofi";
        };
      };
    }
    // lib.optionalAttrs (user.machine != "wsl") {
      hyprland.windowrulev2 = map (rule: rule + ", class:(Rofi)") [
        "float"
        "stayfocused"
      ];

      waybar-workspace-icon."class<Rofi>" = "󰼢 ";
    };
}
