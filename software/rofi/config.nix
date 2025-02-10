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
      hyprland.windowrulev2 = [
        "float, class:(Rofi)"
        "stayfocused, class:(Rofi)"
      ];

      waybar-workspace-icon."class<Rofi>" = "󰼢 ";
    };
}
