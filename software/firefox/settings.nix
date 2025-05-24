{
  lib,
  user,
  ...
}: {
  user-manage.programs.firefox.profiles.${user.name}.settings =
    {
      "app.update.auto" = false; # Disable auto update
      ## -- Downloads
      "browser.download.dir" = user.downloads;
      "browser.download.start_downloads_in_tmp_dir" = true;

      ## -- Visual debloat
      "identity.fxaccounts.enabled" = false; # Disable Firefox Accounts integration (Sync)
      "extensions.screenshots.disabled" = true; # Remove access to Firefox Screenshots.
      "extensions.pocket.enabled" = false; # Remove Pocket in the Firefox UI. It does not remove it from the new tab page.
      "print.enabled" = false; # Disables print this page option
      "media.videocontrols.picture-in-picture.video-toggle.enabled" = false; # Disables picture in picture option
      "browser.newtabpage.activity-stream.showSponsoredTopSites" = false; # It removes sponsored sites from the new tab page
      "browser.aboutConfig.showWarning" = false; # Disable warning when entering about:config
      "browser.toolbars.bookmarks.visibility" = "never"; # Hides the bookmarks bar

      ## -- Features
      "app.normandy.first_run" = false; # Prevents firefox from noticing first time run
      "pdfjs.disabled" = false; # Enable built in pdf viewer
      "browser.shell.checkDefaultBrowser" = false; # Don’t check if Firefox is the default browser at startup
      "browser.translations.enable" = false; # Disable webpage translation
      "extensions.autoDisableScopes" = 0; # Automatically enable extensions
      # Customize Firefox Suggest
      "browser.urlbar.quicksuggest.dataCollection.enabled" = false;
      "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
      "browser.urlbar.suggest.quicksuggest.sponsored" = false;

      ## -- Privacy (Also performance I hope, since is not sending anything)
      "dom.security.https_only_mode" = true; # Configure HTTPS-Only Mode
      "signon.rememberSignons" = false; # Control whether or not Firefox offers to save passwords
      "pref.privacy.disable_button.view_passwords" = true; # Remove access to the password manager via preferences and blocks about:logins
      # Disable Telemetry
      "datareporting.healthreport.uploadEnabled" = false;
      "datareporting.policy.dataSubmissionEnabled" = false;
      "toolkit.telemetry.archive.enabled" = false;
      # Disable Firefox studies (Shield)
      "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
      "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
      # Tracking protection
      "privacy.trackingprotection.enabled" = true;
      "privacy.trackingprotection.pbmode.enabled" = true;
      "privacy.trackingprotection.cryptomining.enabled" = true;
      "privacy.trackingprotection.fingerprinting.enabled" = true;
    }
    // lib.optionalAttrs (user.machine == "desktop") {
      "layers.acceleration.disabled" = false; # Performance - Control hardware acceleration

      ## -- Restore session
      "browser.startup.page" = 3; # 0 = blank page, 1 = homepage, 3 = restore previous session
      "browser.sessionstore.resume_session_once" = false; # If true, only restore the session once, if false, always restore session
      "browser.sessionstore.resume_from_crash" = true; # Try to restore the session after a crash
    };
}
