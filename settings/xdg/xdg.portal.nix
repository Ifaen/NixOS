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

  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
    xdgOpenUsePortal = true;

    config."Hyprland" = {
      default = ["hyprland" "gtk"];
      "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
    };
  };

  home-manager.users.${user.name} = {
    xdg.configFile."gtk-3.0/bookmarks".text = ''
      file://${user.home}/NixOS
      file://${user.home}/Documents
      file://${user.home}/Downloads
      file://${user.home}/Media
      file://${user.home}/Sync
    '';

    wayland.windowManager.hyprland.settings.windowrulev2 = [
      "size 60% 80%, class:(xdg-desktop-portal-gtk)"
      "float, class:(xdg-desktop-portal-gtk)"
      "float, title:(Save File)"
    ];

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite = {
      "class<xdg-desktop-portal-gtk>" = "";
      "title<Save As>" = "";
      "title<Save File>" = "";
      "title<Save Image>" = "";
      "title<Open Folder>" = "";
      "title<Enter name of file to save to…>" = "";
    };
  };
}
