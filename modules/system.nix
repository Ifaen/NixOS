{
  lib,
  config,
  user,
  ...
}: {
  # Enable flakes and auto optimise /nix/store
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;
    warn-dirty = false; # Hide the warning when the store is dirty
  };

  networking.hostName = user.hostname; # Hostname of system

  users = {
    mutableUsers = false; # Prevents to create or modify new users besides the declared

    users.root.hashedPassword = "!"; # Disable root user
  };

  boot = {
    loader = {
      grub =
        {
          enable = true;
          devices = ["nodev"];
          efiSupport = true;
        }
        // lib.optionalAttrs (user.hostname == "desktop") {
          useOSProber = true; # Append entries for other OSs detected by os-prober
        };

      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };

      timeout =
        if user.hostname == "desktop"
        then 60 # Timeout for desktop is longer because of dual boot
        else 5;
    };

    tmp.cleanOnBoot = true;
  };

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "es_CL.UTF-8";
      LC_IDENTIFICATION = "es_CL.UTF-8";
      LC_MEASUREMENT = "es_CL.UTF-8";
      LC_MONETARY = "es_CL.UTF-8";
      LC_NAME = "es_CL.UTF-8";
      LC_NUMERIC = "es_CL.UTF-8";
      LC_PAPER = "es_CL.UTF-8";
      LC_TELEPHONE = "es_CL.UTF-8";
      LC_TIME = "es_CL.UTF-8";
    };
  };

  system.stateVersion = "25.05"; # Before changing, read https://nixos.org/nixos/options.html.
  user-manage.home.stateVersion = config.system.stateVersion; # The same of the system
}
