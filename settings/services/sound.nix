{
  pkgs,
  user,
  ...
}: {
  sound.enable = true;

  environment.systemPackages = with pkgs; [
    pavucontrol # Audio controller
    pw-volume # Basic interface for PipeWire volume controls
    stable.spotify # Music provider
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
  home-manager.users.${user.name} = {
    wayland.windowManager.hyprland.settings = {
      exec-once = ["[workspace 12 silent] spotify"];
      windowrulev2 = [
        "float, class:(pavucontrol)"
        "size 60% 80%, class:(pavucontrol)"
        "opacity 0.95 1, class:^(Spotify)$"
      ];
    };
    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite = {
      "class<Spotify>" = "󰓇";
      "class<pavucontrol>" = "󰕾"; # nf-md-volume_high
    };
  };
}
