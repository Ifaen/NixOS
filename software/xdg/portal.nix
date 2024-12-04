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

    # Re-direct variable towards the correct path so the xdg-desktop-portal.service finds the DE-portals.conf
    home.sessionVariables.NIXOS_XDG_DESKTOP_PORTAL_CONFIG_DIR = "${user.dir.config}/xdg-desktop-portal";

    wayland.windowManager.hyprland.settings.windowrulev2 = [
      "float, title:^(.*Save.*)$"
      "rounding 10, title:^(.*Save.*)$"
      "opacity 0.75, title:^(.*Save.*)$"
      "float, class:(Xdg-desktop-portal-kde)"
      "rounding 10, class:(Xdg-desktop-portal-kde)"
      "opacity 0.75, class:(Xdg-desktop-portal-kde)"
      "float, title:(Media viewer)"
      "rounding 10, title:(Media viewer)"
      "size 80% 80%, title:(Media viewer)"
    ];

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite."class<xdg-desktop-portal-kde>" = "";
  };
}
