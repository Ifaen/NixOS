{...}: {
  user-manage.programs.firefox.policies = {
    DisableFeedbackCommands = true; # Disable the menus for reporting sites (Submit Feedback, Report Deceptive Site).

    DisableForgetButton = true; # Disable the “Forget” button

    PrivateBrowsingModeAvailability = 1; # Disable the option for private browsing
    DisableSetDesktopBackground = true; # Remove the “Set As Desktop Background…” menuitem when right clicking on an image
    ShowHomeButton = false;

    # Features
    DisableProfileImport = true; # Disables the “Import data from another browser” option in the bookmarks window.
    DisableSafeMode = true; # Disable safe mode within the browser.

    # Privacy
    DisableMasterPasswordCreation = true; # Require or prevent using a primary (formerly master) password
  };
}
