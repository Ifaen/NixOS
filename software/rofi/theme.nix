{
  lib,
  user,
  ...
}: {
  user.manage = {
    xdg.configFile."rofi/style.rasi".source = ./style.rasi;

    programs.rofi = {
      theme = lib.mkForce "style.rasi"; # Force it because pywal seems to try and create an .rasi upon build

      #font = "";
    };
  };
}
