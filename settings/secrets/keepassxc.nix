{
  config,
  pkgs,
  user,
  ...
}: {
  user.manage = {
    home.packages = [pkgs.keepassxc];

    xdg.desktopEntries.keepassxc-rofi = {
      name = "KeePassXC";
      exec = "${pkgs.keepassxc}/bin/keepassxc";
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

    xdg.configFile."keepassxc/keepassxc.ini" = {
      enable = true;
      text = ''
        [General]
        BackupBeforeSave=true
        BackupFilePathPattern=${user.home}/Sync/Keepass/{DB_FILENAME}.old.kdbx
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
        Length=20

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
    };

    wayland.windowManager.hyprland.settings.workspace = ["13, on-created-empty:keepassxc"];

    services.xremap.config.keymap = [
      {
        name = "workspace";

        remap = {
          super-k.launch = ["hyprctl" "dispatch" "workspace" "13"];
          super-shift-k.launch = ["hyprctl" "dispatch" "movetoworkspace" "13"];
        };
      }
    ];

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite = {"class<org.keepassxc.KeePassXC>" = "󰌋 ";};
  };

  ## Sync folder with mobile device
  services.syncthing.settings.folders."Keepass" = {
    path = "${config.services.syncthing.dataDir}/Keepass";
    devices = ["mobile"];
  };
}
