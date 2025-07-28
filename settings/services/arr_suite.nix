{user, ...}: {
  services = {
    # An indexer manager/proxy for Torrent trackers. Port: 9696
    prowlarr.enable = true;

    # For Movies. Port: 7878
    radarr = {
      enable = false;
      user = "radarr";
      group = "media";
      openFirewall = true;
    };

    # For TV Shows. Port: 8989
    sonarr = {
      enable = true;
      user = "sonarr";
      group = "media";
      openFirewall = true;
    };

    # For Music. Port: 8686
    lidarr = {
      enable = false;
      user = "lidarr";
      group = "media";
      openFirewall = true;
    };

    # For Subtitles. Port: 6767
    bazarr = {
      enable = false;
      user = "bazarr";
      group = "media";
      openFirewall = true;
    };
  };

  # Add user and all others to media group
  users.groups.media.members = [
    "bazarr"
    "radarr"
    "sonarr"
    "lidarr"
  ];

  # Permissions
  systemd.tmpfiles.rules = [
    "d ${user.home} 0701 ${user.name} users -" # Allows All to traverse home folder
    "d ${user.downloads} 0701 ${user.name} users -" # Allows All to traverse Downloads folder
    "d ${user.downloads}/QBitTorrent 0770 ${user.name} media -" # Allows Media group to control QBitTorrent folder
    # Allows Media group to control Entertainment folder and subdirectories
    "d ${user.documents}/Entertainment 0750 ${user.name} media -"
    "d ${user.documents}/Entertainment/Shows 0770 ${user.name} media -"
    "d ${user.documents}/Entertainment/Movies 0770 ${user.name} media -"
    "d ${user.documents}/Entertainment/Music 0770 ${user.name} media -"
  ];
}
