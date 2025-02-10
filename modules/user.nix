{
  lib,
  config,
  user,
  ...
}: {
  config =
    {
      nix.settings.trusted-users = ["${user.name}"];

      user-manage = {
        programs.home-manager.enable = true; # Let Home Manager install and manage itself

        home = {
          username = user.name;
          homeDirectory = user.home;
        };
      };

      time = {
        timeZone = "America/Santiago"; # Configure timezone
        hardwareClockInLocalTime = true; # Keep the hardware clock in local time instead of UTC
      };
    }
    // lib.optionalAttrs (user.machine != "wsl") {
      user-configuration = {
        isNormalUser = true;

        description = user.fullname;

        extraGroups = [
          "networkmanager"
          "wheel"
        ];

        # NOTE: To generate a hashed password run `mkpasswd`
        hashedPassword = "$6$mPfCRmBsa0vLp6Hl$kw2/2SpSr9UdqzZ65.4/D0cmgyERlhy0VM.OS8KHmdc5bZW2CY7oyz8JZL2hp1yBi2FIkeJdjFdyI9ketviG11";
      };

      console = {
        enable = true; # Whether to enable virtual console
        keyMap = user.language; # Configure console keymap
      };
    };
}
