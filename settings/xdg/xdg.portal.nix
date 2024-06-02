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

  home-manager.users.${user.name} = {
    xdg.portal = {
      enable = true;

      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];
      xdgOpenUsePortal = true;

      config."hyprland" = {
        default = ["hyprland" "gtk"];
        "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
      };
    };

    xdg.configFile."gtk-3.0/bookmarks".text = ''
      file://${user.home}/NixOS
      file://${user.home}/Documents
      file://${user.home}/Downloads
      file://${user.home}/Media
      file://${user.home}/Sync
    '';

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite = {
      "title<Save As>" = "";
      "title<Save Image>" = "";
      "title<Open Folder>" = "";
      "title<Enter name of file to save to…>" = "";
    };
  };
}
