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

  home-manager.users.${user.name} = {config, ...}: {
    xdg.configFile."gtk-2.0/gtkfilechooser.ini".text = ''
      [Filechooser Settings]
      LocationMode=path-bar
      ShowHidden=true
      ShowSizeColumn=true
      GeometryX=1920
      GeometryY=0
      GeometryWidth=742
      GeometryHeight=753
      SortColumn=name
      SortOrder=ascending
      StartupMode=cwd
      DefaultFolder=cwd
    '';

    gtk = {
      gtk2 = {
        configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

        extraConfig = ''
          gtk-recent-files-max-age=0
        '';
      };

      gtk3 = {
        bookmarks = [
          "file://${user.home}/NixOS"
          "file://${user.home}/Documents"
          "file://${user.home}/Downloads"
          "file://${user.home}/Media"
          "file://${user.home}/Sync"
        ];

        extraConfig.gtk-recent-files-enabled = 0;
      };

      gtk4.extraConfig.gtk-recent-files-enabled = 0;
    };

    wayland.windowManager.hyprland.settings.windowrulev2 = [
      "size 60% 80%, class:(xdg-desktop-portal-gtk)"
      "size 60% 80%, class:(Xdg-desktop-portal-gtk)"
      "float, class:(xdg-desktop-portal-gtk)"
      "float, title:(Save File)"
      "float, title:(Save Video)"
      "float, title:(Save Image)"
    ];

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite = {
      "class<xdg-desktop-portal-gtk>" = " ";
      "title<Save As>" = " ";
      "title<Save File>" = " ";
      "title<Save Image>" = " ";
      "title<Open Folder>" = " ";
      "title<Enter name of file to save to…>" = " ";
    };
  };
}
