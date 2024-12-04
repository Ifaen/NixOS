{pkgs, ...}: {
  user-manage = {
    programs.foot = {
      enable = true;
      server.enable = false;
    };

    xdg.desktopEntries.foot-rofi = {
      name = "Foot Terminal";
      exec = "${pkgs.foot}/bin/foot %U";
      terminal = false;
      icon = "foot";
      categories = ["X-Rofi" "System" "TerminalEmulator"];
    };

    hyprland.exec-once = ["[workspace 11 silent] foot"];

    waybar-workspace-icon."class<foot>" = "󰆍 ";
  };
}
