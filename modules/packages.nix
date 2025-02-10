{
  lib,
  pkgs,
  user,
  ...
}: {
  user-manage = lib.optionalAttrs (user.machine == "desktop") {
    home.packages = with pkgs; [
      brave # Second browser in case primary throws an error
      file
      libreoffice # Open Source microsoft 365 alternative
    ];

    waybar-workspace-icon = {
      "class<org.telegram.desktop>" = " ";
      "class<Brave-browser>" = " ";
    };
  };
}
