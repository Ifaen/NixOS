{user, ...}: {
  # Add user to respective groups to allow uinput to work
  hardware.uinput.enable = true;
  users.groups = {
    uinput.members = ["${user.name}"];
    input.members = ["${user.name}"];
  };

  user.manage = {
    services.xremap = {
      enable = true;
      withWlroots = true; # To work in wayland

      watch = true; # Watch for devices connected after service started

      mouse = true;

      deviceNames = [
        "USB OPTICAL MOUSE"
        "2.4G RF Keyboard & Mouse"
        "Razer Razer Cynosa Lite"
        "Kingston HyperX Cloud Stinger Core Wireless" # Wireless headphones
        "ydotoold virtual device" # ydotool
      ];
    };

    # Workaround to reset the service of xremap after logout of hyprland
    wayland.windowManager.hyprland.settings.exec-once = ["systemctl --user restart xremap"];
  };
}
