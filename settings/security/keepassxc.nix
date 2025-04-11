{
  config,
  pkgs,
  user,
  ...
}: {
  user-manage = {
    home.packages = [pkgs.keepassxc];

    xdg.configFile."keepassxc/keepassxc.ini" = {
      force = true;

      text = ''
        [General]
        BackupBeforeSave=true
        UseGroupIconOnEntryCreation=false
        BackupFilePathPattern=${user.sync}/Keepass/{DB_FILENAME}.old.kdbx
        FaviconDownloadTimeout=15
        NumberOfRememberedLastDatabases=1
        RememberLastKeyFiles=false
        UseAtomicSaves=false

        [Browser]
        CustomProxyLocation=
        Enabled=true

        [FdoSecrets]
        Enabled=false

        [GUI]
        ApplicationTheme=dark
        ColorPasswords=true
        CompactMode=true
        HideMenubar=true
        HidePreviewPanel=true
        HideToolbar=false
        HideUsernames=false
        TrayIconAppearance=monochrome-light

        [PasswordGenerator]
        AdditionalChars=
        ExcludedChars=
        Length=20

        [SSHAgent]
        Enabled=true

        [Security]
        ClearClipboardTimeout=60
        ClearSearch=true
        ClearSearchTimeout=2
        EnableCopyOnDoubleClick=true
        HidePasswordPreviewPanel=true
        HideTotpPreviewPanel=true
        IconDownloadFallback=true
        LockDatabaseIdle=false
        LockDatabaseIdleSeconds=600
        LockDatabaseMinimize=true
        NoConfirmMoveEntryToRecycleBin=false
        Security_HideNotes=true
        PasswordEmptyPlaceholder=true
      '';
    };

    xdg.desktopEntries."org.keepassxc.KeePassXC" = {
      name = "KeePassXC";
      exec = "keepassxc";
      mimeType = ["application/x-keepass2"];
      categories = ["X-Rofi" "Utility" "Security"];
      icon = "keepassxc";
      startupNotify = true;
      terminal = false;
      settings = {
        SingleMainWindow = "true";
        X-GNOME-SingleWindow = "true";
      };
    };

    hyprland = {
      windowrulev2 = [
        "pin, title:(Unlock Database - KeePassXC)"
        "focusonactivate, title:(Unlock Database - KeePassXC)"

        "pin, title:(KeePassXC - Browser Access Request)"
        "focusonactivate, title:(KeePassXC - Browser Access Request)"
      ];

      workspace = ["9, on-created-empty:keepassxc"];
    };
  };

  # -- Sync folder with mobile device
  services.syncthing.settings.folders."Keepass" = {
    path = "${config.services.syncthing.dataDir}/Keepass";
    devices = ["mobile"];
  };
}
