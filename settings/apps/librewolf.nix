{
  lib,
  pkgs,
  user,
  ...
}: {
  programs.librewolf = {
    enable = true;
    settings = {
      "identity.fxaccounts.enabled" = true; # Allow mozilla accounts to sync
      "widget.gtk.overlay-scrollbars.enabled" = false; # Always show scrollbars
      "browser.startup.page" = 3; # 3 to resume previous tabs. Default: 1
      "media.videocontrols.picture-in-picture.video-toggle.enabled" = false; # Disable picture in picture toggle
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true; # Customization through css
      "browser.translations.enable" = false; # Disable translate pages
      "privacy.clearOnShutdown.history" = false; # Prevent from deleting history to allow startup.page to work
      "privacy.clearOnShutdown.cache" = false; # Prevent from deleting cache to stay logged in pages
      "privacy.clearOnShutdown.cookies" = false; # Prevent from deleting cookies to stay logged in pages
      "privacy.clearOnShutdown.offlineApps" = false; # Prevent from deleting offlineApps to stay logged in pages
    };
  };

  home.file = {
    librewolf-profile = {
      enable = true;
      text = ''
        [Profile0]
        Name=default
        IsRelative=1
        Path=${user.name}
        Default=1

        [General]
        StartWithLastProfile=1
      '';
      target = "${user.home}/.librewolf/profiles.ini";
    };
    librewolf-userChrome = {
      enable = true;
      # hides the native tabs
      text = ''
        #TabsToolbar, #sidebar-header {
          display: none !important;
        }
        #titlebar {
          visibility: collapse;
        }
      '';
      target = "${user.home}/.librewolf/${user.name}/chrome/userChrome.css";
    };
  };

  # Other browsers
  home.packages = [pkgs.brave];

  # Settings of firefox in other modules
  wayland.windowManager.hyprland.settings.exec-once = ["[workspace 1] librewolf"];

  programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite = {
    "class<Brave-browser>" = "";
    "class<librewolf>" = "󰈹"; # nf-md-firefox
  };
}
