{pkgs, ...}: {
  user-manage = {
    home.packages = with pkgs; [
      file # To easily know the mimeapp and more
      brave # Second browser in case primary throws an error
      vdhcoapp # Companion application for the Video DownloadHelper browser add-on.
    ];

    waybar-workspace-icon = {
      "class<org.telegram.desktop>" = " ";
      "class<Brave-browser>" = " ";
    };
  };
}
