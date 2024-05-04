{
  pkgs,
  user,
  ...
}: {
  services.gnome.gnome-keyring.enable = true; # Enable Keyring managing

  # Add gnome keyring to pam services # TODO Make sure if is needed when is invoked through xdg portal
  /*
  security.pam.services = {
    login.enableGnomeKeyring = true;
    auth.enableGnomeKeyring = true;
  };
  */

  home-manager.users.${user.name} = {
    xdg.portal = {
      enable = true;

      config.hyprland = {
        default = ["hyprland" "gtk"];
        "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
      };

      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];
      xdgOpenUsePortal = true;
    };

    wayland.windowManager.hyprland.settings.windowrulev2 = [
      "size 60% 80%, class:(xdg-desktop-portal-gtk)"
      "center, class:(xdg-desktop-portal-gtk)"
    ];

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite."class<xdg-desktop-portal-gtk>" = "";
  };
}
