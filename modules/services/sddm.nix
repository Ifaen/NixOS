{user, ...}: {
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;

    settings.Autologin = {
      User = user.name;
      Session = "hyprland.desktop";
    };

    autoNumlock = true;
  };
}
