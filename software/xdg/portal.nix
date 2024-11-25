{
  pkgs,
  user,
  ...
}: {
  # Enable Keyring managing
  services.gnome.gnome-keyring.enable = true;

  # Add gnome keyring to pam services
  security.pam.services = {
    login.enableGnomeKeyring = true;
    auth.enableGnomeKeyring = true;
  };

  environment.pathsToLink = ["/share/xdg-desktop-portal" "/share/applications"];

  user.manage = {
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;

      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
        xdg-desktop-portal-kde
      ];

      config."hyprland" = {
        default = [
          "hyprland"
          "gtk"
          "kde"
        ];

        "org.freedesktop.impl.portal.FileChooser" = "kde";
        "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
      };
    };

    home = {
      packages = [
        pkgs.libsForQt5.qtwayland
        pkgs.libsForQt5.kio-extras
        pkgs.libsForQt5.ffmpegthumbs
        pkgs.libsForQt5.kdegraphics-thumbnailers
        pkgs.libsForQt5.qtimageformats
      ];

      # Re-direct variable towards the correct path so the xdg-desktop-portal.service finds the DE-portals.conf
      sessionVariables.NIXOS_XDG_DESKTOP_PORTAL_CONFIG_DIR = "${user.dir.config}/xdg-desktop-portal";
    };

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite = {
      "class<xdg-desktop-portal-kde>" = "";
    };
  };
}
