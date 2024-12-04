{pkgs, ...}: {
  user.manage = {
    # When `libcurl-gnutls.so.4: no version information...` appears, clear Spotify's cache with `rm -rf ~/.cache/spotify`
    home.packages = [pkgs.spotify];

    xdg.desktopEntries.spotify = {
      name = "Spotify";
      exec = "${pkgs.spotify}/bin/spotify %U";
      mimeType = ["x-scheme-handler/spotify"];
      categories = ["X-Rofi" "Audio" "Music" "Player" "AudioVideo"];
      icon = "spotify-client";
      terminal = false;
      settings.StartupWMClass = "spotify";
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
      workspace = ["12, on-created-empty:spotify"];

      windowrulev2 = ["opacity 0.95, class:(Spotify)"];
    };

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite = {"class<Spotify>" = "󰓇 ";};
  };
}
