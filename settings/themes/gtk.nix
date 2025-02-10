{
  pkgs,
  user,
  ...
}: {
  programs.dconf.enable = true;

  user-manage.gtk = {
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

    gtk2.configLocation = "${user.config}/gtk-2.0/gtkrc"; # Move the gtk config file away from $HOME

    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
  };
}
