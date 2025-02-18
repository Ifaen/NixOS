{
  lib,
  pkgs,
  user,
  ...
}: {
  user-manage = lib.optionalAttrs (user.machine == "desktop") {
    home.packages = with pkgs; [
      file # To easily know the mimeapp and more
      brave # Second browser in case primary throws an error
      vdhcoapp # Companion application for the Video DownloadHelper browser add-on.
      libreoffice # Open Source microsoft 365 alternative
    ];

    waybar-workspace-icon = {
      "class<org.telegram.desktop>" = " ";
      "class<Brave-browser>" = " ";
    };
  };
}
