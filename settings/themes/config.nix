{
  pkgs,
  user,
  ...
}: let
  cursor-name = "Bibata_Ghost";
  cursor-size = 40;
in {
  user.manage = {
    programs.pywal.enable = true; # Generate and change colorschemes on the fly

    ## THEME
    gtk = {
      enable = true;

      theme = {
        package = pkgs.adw-gtk3;
        name = "adw-gtk3-dark";
      };

      iconTheme = {
        package = pkgs.vimix-icon-theme;
        name = "Vimix-Black";
      };

      font = {
        name = "monospace";
        size = 13;
      };

      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
    };

    qt = {
      enable = true;

      platformTheme.name = "gtk3";

      style = {
        name = "adwaita-dark";
        package = pkgs.adwaita-qt;
      };
    };

    # -- Make apps use Wayland over Xwayland → https://wiki.hyprland.org/Configuring/Environment-variables/
    wayland.windowManager.hyprland.settings.env = [
      "GDK_BACKEND,wayland,x11,*" # GTK: Use wayland if available. If not: try x11, then any other GDK backend
      "QT_QPA_PLATFORM, wayland;xcb" # Qt: Use wayland if available, fall back to x11 if not

      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1" # Disables window decorations on Qt applications
    ];
  };
}
