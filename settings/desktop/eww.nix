{pkgs, ...}: {
  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
  };

  /*
  home.file.
  */
}
