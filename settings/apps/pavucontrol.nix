{pkgs, ...}: {
  user-manage = {
    home.packages = [
      pkgs.pavucontrol
    ];

    xdg.desktopEntries.pavucontrol = {
      name = "Pavucontrol";
      exec = "${pkgs.pavucontrol}/bin/pavucontrol";
      categories = ["X-Rofi" "AudioVideo" "Audio" "Mixer" "Settings"];
      icon = "multimedia-volume-control";
      startupNotify = true;
      terminal = false;
    };

    hyprland.windowrulev2 = [
      "float, class:(pavucontrol)"
      "size 60% 80%, class:(pavucontrol)"
    ];

    waybar-workspace-icon."class<pavucontrol>" = "󰕾 "; # nf-md-volume_high
  };
}
