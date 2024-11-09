{
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user.name} = {config, ...}: {
    # When `libcurl-gnutls.so.4: no version information` appears, clear Spotify's cache with `rm -rf ~/.cache/spotify`
    home.packages = [pkgs.spotify];

    xdg.desktopEntries.spotify-rofi = {
      name = "Spotify";
      exec = "${pkgs.spotify}/bin/spotify --enable-features=UseOzonePlatform --ozone-platform=wayland %U"; # Use wayland instead of xwayland
      mimeType = ["x-scheme-handler/spotify"];
      categories = ["X-Rofi" "Audio" "Music" "Player" "AudioVideo"];
      icon = "spotify-client";
      terminal = false;
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

    wayland.windowManager.hyprland.settings = {
      workspace = ["12, on-created-empty:${config.xdg.desktopEntries.spotify-rofi.exec}"];

      windowrulev2 = ["opacity 0.95, class:(Spotify)"];
    };

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite = {"class<Spotify>" = "󰓇 ";};
  };
}
