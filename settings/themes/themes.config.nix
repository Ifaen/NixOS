{
  pkgs,
  user,
  ...
}: let
  cursor-name = "Bibata_Ghost";
  cursor-size = 40;
in {
  home-manager.users.${user.name} = {
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

    ## CURSOR
    home.pointerCursor = {
      gtk.enable = true;

      package = pkgs.bibata-cursors-translucent;
      name = cursor-name;
      size = cursor-size;
    };

    wayland.windowManager.hyprland.settings = {
      env = [
        "XCURSOR_SIZE, ${toString cursor-size}"
        "QT_QPA_PLATFORM, wayland"
      ];

      exec-once = ["hyprctl setcursor ${cursor-name} ${toString cursor-size}"];
    };
  };
}
