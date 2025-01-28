{pkgs, ...}: {
  user-manage = {
    home.packages = [
      pkgs.file
      pkgs.brave # Second browser in case primary throws an error
    ];

    waybar-workspace-icon = {
      "class<org.telegram.desktop>" = " ";
      "class<Brave-browser>" = " ";
    };
  };
}
