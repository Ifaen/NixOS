{pkgs, ...}: {
  user-manage = {
    home.packages = [pkgs.pavucontrol];

    xdg.desktopEntries.pavucontrol = {
      name = "Pavucontrol";
      exec = "pavucontrol";
      categories = ["X-Rofi" "AudioVideo" "Audio" "Mixer" "Settings"];
      icon = "multimedia-volume-control";
      startupNotify = true;
      terminal = false;
    };

    hyprland.windowrulev2 = map (rule: rule + ", class:(org.pulseaudio.pavucontrol)") [
      "float"
      "size 60% 80%"
    ];

    waybar-workspace-icon."class<org.pulseaudio.pavucontrol>" = "󰕾 "; # nf-md-volume_high
  };
}
