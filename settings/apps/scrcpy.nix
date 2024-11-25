{pkgs, ...}: {
  user.manage = {
    home.packages = [pkgs.scrcpy];

    xdg.desktopEntries.scrcpy = {
      name = "Scrcpy";
      exec = "${pkgs.scrcpy}/bin/scrcpy -w %U";
      categories = ["X-Rofi"];
      icon = "scrcpy";
      terminal = false;
    };

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite = {"class<.scrcpy-wrapped>" = " ";};
  };
}
