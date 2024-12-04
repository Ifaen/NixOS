{pkgs, ...}: {
  user.manage = {
    qt = {
      enable = true;

      platformTheme.name = "gtk3";

      style = {
        name = "adwaita-dark";
        package = pkgs.adwaita-qt;
      };
    };

    # For all QT apps that need to show thumbnails
    home.packages = [
      pkgs.libsForQt5.qtwayland
      pkgs.libsForQt5.kio-extras
      pkgs.libsForQt5.ffmpegthumbs
      pkgs.libsForQt5.kdegraphics-thumbnailers
      pkgs.libsForQt5.qtimageformats
    ];
  };
}
