{
  pkgs,
  user,
  ...
}: {
  sound.enable = true;

  environment.systemPackages = with pkgs; [
    pavucontrol # Audio controller
    pw-volume # Basic interface for PipeWire volume controls
    spotify # Music provider. If you get: libcurl-gnutls.so.4: no version information, then clear your Spotify cache rm -rf ~/.cache/spotify
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
      workspace = ["12, on-created-empty:spotify"];

      windowrulev2 = [
        "float, class:(pavucontrol)"
        "size 60% 80%, class:(pavucontrol)"
        "opacity 0.95, class:(Spotify)"
      ];
    };

    services.xremap.config.keymap = [
      {
        name = "workspace";

        remap = {
          super-s.launch = ["hyprctl" "dispatch" "workspace" "12"];
          super-shift-s.launch = ["hyprctl" "dispatch" "movetoworkspace" "12"];
        };
      }
    ];

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite = {
      "class<Spotify>" = "󰓇 ";
      "class<pavucontrol>" = "󰕾 "; # nf-md-volume_high
    };
  };
}
