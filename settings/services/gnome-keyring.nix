{pkgs, ...}: {
  # Enable Keyring managing
  user-manage = {
    # Enable gnome-keyring
    services.gnome-keyring = {
      enable = true;
      components = ["secrets"];
    };

    # Provides org.gnome.keyring.SystemPrompter
    home.packages = [pkgs.gcr];

    # Set gnome-keyring as the default keyring for hyprland
    xdg.portal.config.hyprland."org.freedesktop.impl.portal.Secret" = "gnome-keyring";

    #hyprland.exec-once = ["${pkgs.gnome.gnome-keyring}/bin/gnome-keyring-daemon --start --components=secrets"];
  };

  # Add to PAM
  security.pam.services = {
    login.enableGnomeKeyring = true;
    sddm.enableGnomeKeyring = true;
  };
}
