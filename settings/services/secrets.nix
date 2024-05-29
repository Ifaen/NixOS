{
  config,
  pkgs,
  user,
  ...
}: {
  ## POLKIT
  security = {
    polkit.enable = true; # To give super user rights to apps when required
    rtkit.enable = true; # A daemon that hands out real-time priority to processes
  };

  systemd.user.services.polkit-kde-authentication-agent-1 = {
    description = "polkit-kde-authentication-agent-1";
    wantedBy = ["graphical-session.target"];
    wants = ["graphical-session.target"];
    after = ["graphical-session.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  ## KEEPASSXC
  home-manager.users.${user.name} = {
    home.packages = [pkgs.keepassxc];

    xdg.configFile."keepassxc/keepassxc.ini".text = ''
      [General]
      BackupBeforeSave=true
      BackupFilePathPattern=${user.home}/Sync/.keepass/{DB_FILENAME}.old.kdbx
      FaviconDownloadTimeout=15
      NumberOfRememberedLastDatabases=1
      RememberLastKeyFiles=false
      UseGroupIconOnEntryCreation=false

      [Browser]
      CustomProxyLocation=
      Enabled=true

      [GUI]
      ApplicationTheme=dark
      ColorPasswords=true
      CompactMode=true
      HidePreviewPanel=false
      HideToolbar=false
      HideUsernames=false
      TrayIconAppearance=monochrome-light

      [PasswordGenerator]
      AdditionalChars=
      ExcludedChars=
      Length=30

      [Security]
      ClearClipboardTimeout=30
      ClearSearch=true
      ClearSearchTimeout=2
      EnableCopyOnDoubleClick=true
      HidePasswordPreviewPanel=true
      HideTotpPreviewPanel=true
      IconDownloadFallback=true
      LockDatabaseIdle=true
      LockDatabaseMinimize=true
      NoConfirmMoveEntryToRecycleBin=false
      Security_HideNotes=true
    '';

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite = {
      "class<org.keepassxc.KeePassXC>" = "󰌋";
      "class<polkit-kde-authentication-agent-1>" = "󰌾"; # nf-md-lock
    };
  };

  ## SYNCTHING
  services.syncthing = {
    enable = true;
    user = "${user.name}";

    dataDir = "${config.home-manager.users.${user.name}.xdg.userDirs.extraConfig.sync}"; # Obtain the name of sync folder in the extraconfig of xdg
    configDir = "${user.home}/.config/syncthing";

    settings = {
      devices."mobile".id = "FDD6P6K-OV6LVEX-BPUKI6F-2CCANDX-KAHGOSV-5JTU4BC-NISJSGW-3YES5QX";

      folders."Keepass" = {
        path = "${config.services.syncthing.dataDir}/.keepass";
        devices = ["mobile"];
      };
    };

    # overrides any folders and devices added or deleted through the WebUI
    overrideDevices = true;
    overrideFolders = true;
  };
}
