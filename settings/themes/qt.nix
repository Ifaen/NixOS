{pkgs, ...}: {
  user-manage = {
    qt = {
      enable = true;

      platformTheme.name = "gtk3";

      style = {
        name = "adwaita-dark";
        package = pkgs.adwaita-qt;
      };
    };

    # For all QT apps that need to show thumbnails
    home.packages = with pkgs.libsForQt5; [
      qtwayland
      kio-extras
      ffmpegthumbs
      kdegraphics-thumbnailers
      qtimageformats
    ];
  };
}
