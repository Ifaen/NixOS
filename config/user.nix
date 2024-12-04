{user, ...}: {
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

  nix.settings.trusted-users = ["${user.name}"];

  user-manage = {
    programs.home-manager.enable = true; # Let Home Manager install and manage itself

    home = {
      username = user.name;
      homeDirectory = user.home;
    };
  };

  networking.hostName = user.machine; # Hostname of system

  time.timeZone = "America/Santiago"; # Configure timezone

  console.keyMap = user.language; # Configure console keymap
}
