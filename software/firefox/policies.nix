{
  lib,
  user,
  ...
}: {
  user-manage.programs.firefox.policies =
    {
      # Downloads
      DefaultDownloadDirectory = user.downloads;
      StartDownloadsInTempDirectory = true;

      # Visual bloat
      DisableFeedbackCommands = true;
      DisableFirefoxAccounts = true;
      DisableFirefoxScreenshots = true;
      DisableForgetButton = true;
      DisablePocket = true;
      DisablePrivateBrowsing = true;
      DisableSetDesktopBackground = true;
      PrintingEnabled = false;
      PictureInPicture.Enabled = false;
      ShowHomeButton = false;

      # Features
      DisableBultinPDFViewer = true;
      DisableProfileImport = true;
      DisableSafeMode = true;
      DontCheckDefaultBrowser = true;
      FirefoxSuggest = {
        WebSuggestions = false;
        SponseredSuggestions = false;
        ImproveSuggest = false;
        Locked = true;
      };
      TranslateEnabled = false;

      #Performance
      DisableAppUpdate = true;

      # Privacy
      DisableFirefoxStudies = true;
      DisableMasterPasswordCreation = true;
      DisableTelemetry = true;
      EnableTrackingProtection = {
        Value = true;
        Cryptomining = true;
        EmailTracking = true;
      };
      HttpsOnlyMode = "enabled";
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;
    }
    // lib.optionalAttrs (user.machine == "desktop") {
      HardwareAcceleration = true; # Performance
      PromptForDownloadLocation = true; # Downloads
    };
}
