{pkgs, ...}: let
  cursor-name = "Bibata_Ghost";
  cursor-size = 40;
in {
  user-manage = {
    hyprland.env = [
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
