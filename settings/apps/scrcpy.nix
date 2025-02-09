{pkgs, ...}: {
  user-manage = {
    home.packages = [pkgs.scrcpy];

    xdg.desktopEntries.scrcpy = {
      name = "Scrcpy";
      exec = "scrcpy -w %U";
      categories = ["X-Rofi"];
      icon = "scrcpy";
      terminal = false;
    };

    waybar-workspace-icon."class<.scrcpy-wrapped>" = " ";
  };
}
