{pkgs, ...}: {
  user-manage = {
    home.packages = [pkgs.file];

    waybar-workspace-icon."class<org.telegram.desktop>" = " ";
  };
}
