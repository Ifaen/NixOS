{
  pkgs,
  user,
  ...
}: {
  fonts = {
    fontDir.enable = true;

    packages = with pkgs; [
      fira-code-nerdfont
      kdePackages.breeze-icons
    ];
  };

  home-manager.users.${user.name} = let
    cursor-name = "Bibata_Ghost";
    cursor-size = 40;
  in {
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
