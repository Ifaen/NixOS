{pkgs, ...}: {
  user.manage.gtk = {
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

    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
  };
}
