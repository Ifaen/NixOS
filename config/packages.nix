{pkgs, ...}: {
  user-manage = {
    # -- Packages
    home.packages = [
      pkgs.file
      pkgs.telegram-desktop # groups
    ];

    waybar-workspace-icon."class<org.telegram.desktop>" = " ";
  };
}
