# Business Aventuras patagonia linktr.ee/aventuraspatagonia
{
  pkgs,
  user,
  ...
}: {
  programs.firefox = {
    enable = true;

    languagePacks = [
      "en-US"
      "es-CL"
      "fr"
    ];

    preferences = {
      "browser.startup.page" = 3; # 3 to resume previous tabs. Default: 1
      "trailhead.firstrun.didSeeAboutWelcome" = true;
    };

    # https://mozilla.github.io/policy-templates/
    policies = {
      DisableFeedbackCommands = true;
      DisableFirefoxScreenshots = true;
      DisablePocket = true;
      DisablePrivateBrowsing = true;
      DisableSetDesktopBackground = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      DownloadDirectory = "${user.home}/Downloads";
      HardwareAcceleration = true; # TODO Test whether this affects somehow my notebook
      OfferToSaveLoginsDefault = false;
      StartDownloadsInTempDirectory = true;
      TranslateEnabled = false;
    };
  };

  home-manager.users.${user.name} = {
    programs.firefox.enable = true; # Allow firefox to be configured per user / profile

    wayland.windowManager.hyprland.settings.exec-once = ["[workspace 1 silent] firefox"];

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite = {
      "class<firefox>" = "󰈹"; # nf-md-firefox
      "class<Brave-browser>" = "";
    };

    # Other browsers
    home.packages = [pkgs.brave];
  };
}
