{
  pkgs,
  user,
  ...
}: let
  cursor-name = "Bibata_Ghost";
  cursor-size = 40;
in {
  home-manager.users.${user.name} = {
    wayland.windowManager.hyprland.settings.env = [
      "HYPRCURSOR_THEME, ${cursor-name}"
      "HYPRCURSOR_SIZE, ${toString cursor-size}"
    ];

    home = {
      packages = [pkgs.hyprcursor];

      pointerCursor = {
        gtk.enable = true;

        package = pkgs.bibata-cursors-translucent;
        name = cursor-name;
        size = cursor-size;
      };
    };
  };
}
