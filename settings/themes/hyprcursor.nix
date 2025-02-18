{
  lib,
  pkgs,
  user,
  ...
}: let
  cursor-name = "Bibata_Ghost";
  cursor-size = 40;
in {
  user-manage =
    {
      home = {
        packages = [pkgs.hyprcursor];

        pointerCursor = {
          gtk.enable = true;

          package = pkgs.bibata-cursors-translucent;
          name = cursor-name;
          size = cursor-size;
        };
      };
    }
    // lib.optionalAttrs (user.machine != "wsl") {
      hyprland.env = [
        "HYPRCURSOR_THEME, ${cursor-name}"
        "HYPRCURSOR_SIZE, ${toString cursor-size}"
      ];
    };
}
