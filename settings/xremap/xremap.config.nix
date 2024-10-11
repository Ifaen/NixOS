{
  config,
  pkgs,
  xremap-flake,
  user,
  ...
}: {
  config = {
    # Add user to respective groups to allow uinput to work
    hardware.uinput.enable = true;
    users.groups = {
      uinput.members = ["${user.name}"];
      input.members = ["${user.name}"];
    };

    environment.systemPackages = [pkgs.ydotool]; # Tool to move cursor using the keyboard

    # Start service for ydotool to detect inputs
    systemd.user.services.ydotoold = {
      description = "ydotool daemon";
      wantedBy = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.ydotool}/bin/ydotoold";
        ExecReload = "${pkgs.util-linux}/bin/kill -HUP $MAINPID";
        KillMode = "Process";
        Restart = "always";
        TimeoutSec = 180;
      };
    };

    home-manager.users.${user.name} = {
      imports = [xremap-flake.homeManagerModules.default];

      services.xremap = {
        enable = true;
        withWlroots = true; # To work in wayland

        watch = true; # Watch for devices connected after service started

        mouse = true;

        deviceNames = [
          "2.4G RF Keyboard & Mouse"
          "Kingston HyperX Cloud Stinger Core Wireless" # Wireless headphones
          "ydotoold virtual device" # ydotool
        ];
      };

      # Workaround to reset the service of xremap after logout of hyprland
      wayland.windowManager.hyprland.settings.exec-once = ["systemctl --user restart xremap"];
    };
  };
}
