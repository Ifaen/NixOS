{pkgs, ...}: {
  user-manage = {
    home.packages = [pkgs.vesktop];

    xdg.desktopEntries.vesktop = {
      name = "Discord";
      exec = "vesktop %U";
      terminal = false;
      icon = "discord";
      categories = ["X-Rofi" "Network" "InstantMessaging"];
    };

    waybar-workspace-icon."class<de.shorsh.discord-screenaudio>" = " ";
  };
}
