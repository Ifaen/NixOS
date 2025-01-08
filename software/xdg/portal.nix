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

  user-manage = {
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;

      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];

      config."hyprland" = {
        default = [
          "hyprland"
          "gtk"
        ];

        "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
      };
    };

    # Re-direct variable towards the correct path so the xdg-desktop-portal.service finds the DE-portals.conf
    home.sessionVariables.NIXOS_XDG_DESKTOP_PORTAL_CONFIG_DIR = "${user.dir.config}/xdg-desktop-portal";

    hyprland.windowrulev2 = [
      "float, class:(.*dg-desktop-portal.*)"
      "stayfocused, class:(.*dg-desktop-portal.*)"
    ];

    waybar-workspace-icon."class<.*dg-desktop-portal.*>" = "";
  };
}
