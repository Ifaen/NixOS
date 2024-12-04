{pkgs, ...}: {
  sound.enable = true;

  environment.systemPackages = with pkgs; [
    pavucontrol # Audio controller
    pw-volume # Basic interface for PipeWire volume controls
  ];

  services.pipewire = {
    enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };

    pulse.enable = true;

    wireplumber.enable = true;
  };

  # Settings of apps in other modules
  user-manage = {
    hyprland.windowrulev2 = [
      "float, class:(pavucontrol)"
      "size 60% 80%, class:(pavucontrol)"
    ];

    waybar-workspace-icon."class<pavucontrol>" = "󰕾 "; # nf-md-volume_high
  };
}
