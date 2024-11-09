{
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user.name} = {
    programs.rofi = {
      enable = true;

      terminal = "${pkgs.foot}/bin/foot";

      extraConfig = {
        show-icons = true;

        drun-categories = "X-Rofi";
      };
    };

    wayland.windowManager.hyprland.settings.windowrulev2 = ["float, class:(Rofi)"];
  };
}
