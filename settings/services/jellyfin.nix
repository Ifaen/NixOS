{
  user,
  pkgs,
  ...
}: {
  # Jellyfin Desktop Client based on Plex Media Player
  user-manage.home.packages = [pkgs.jellyfin-media-player];

  # Enable Jellyfin server
  services.jellyfin = {
    enable = true;
    user = "jellyfin";
    group = "media";
    openFirewall = true;
  };

  # Allow Jellyfin port
  networking.firewall.allowedTCPPorts = [8096];

  # Add user to group
  users.groups.media.members = ["jellyfin"];

  # Desktop Entry
  user-manage.xdg.desktopEntries."com.github.iwalton3.jellyfin-media-player" = {
    name = "Jellyfin Media Player";
    exec = "jellyfinmediaplayer";
    icon = "com.github.iwalton3.jellyfin-media-player";
    categories = ["X-Rofi"];
  };

  # Permissions
  systemd.tmpfiles.rules = [
    "d /var/lib/jellyfin 0750 jellyfin media -" # Allows Media group to navigate to Jellyfin folder
    "d /var/cache/jellyfin 0750 jellyfin media -" # Allows Media group to navigate to Jellyfin cache folder
  ];
}
