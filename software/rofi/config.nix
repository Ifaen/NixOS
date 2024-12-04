{pkgs, ...}: {
  user-manage = {
    programs.rofi = {
      enable = true;

      package = pkgs.rofi-wayland;

      terminal = "${pkgs.foot}/bin/foot";

      extraConfig = {
        show-icons = true;

        drun-categories = "X-Rofi";
      };
    };

    hyprland.windowrulev2 = [
      "float, class:(Rofi)"
      "stayfocused, class:(Rofi)"
      "rounding 10, class:(Rofi)"
    ];

    waybar-workspace-icon."class<Rofi>" = "󰼢 ";
  };
}
