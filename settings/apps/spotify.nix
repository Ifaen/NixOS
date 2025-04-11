{
  lib,
  pkgs,
  user,
  ...
}: {
  user-manage = {
    # When `libcurl-gnutls.so.4: no version information...` appears, clear Spotify's cache with `rm -rf ~/.cache/spotify`
    home.packages = [pkgs.spotify];

    xdg.desktopEntries.spotify = {
      name = "Spotify";
      exec = "spotify %U";
      mimeType = ["x-scheme-handler/spotify"];
      categories = ["X-Rofi" "Audio" "Music" "Player" "AudioVideo"];
      icon = "spotify-client";
      terminal = false;
      settings.StartupWMClass = "spotify";
    };

    hyprland = {
      workspace = ["10, on-created-empty:spotify"];

      windowrulev2 = ["opacity 0.95, class:(Spotify)"];
    };
  };
}
