{config, ...}: {
  # Enable flakes and auto optimise /nix/store
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;
  };

  nixpkgs.config.allowUnfree = true; # Allows unfree packages for nixpkgs

  users = {
    mutableUsers = false; # Prevents to create or modify new users besides the declared

    users.root.hashedPassword = "!"; # Disable root user
  };

  home-manager = {
    useUserPackages = true; # Moves the home-manager packages to /etc/profiles instead of $HOME/.nix-profile
    useGlobalPkgs = true; # To use the same nixpkgs configuration as the nixos system
  };

  boot = {
    loader = {
      grub = {
        enable = true;

        devices = ["nodev"];

        useOSProber = true; # Append entries for other OSs detected by os-prober

        efiSupport = true;
      };

      efi.canTouchEfiVariables = true;

      timeout = 100;
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

  system.stateVersion = "24.05"; # Before changing, read https://nixos.org/nixos/options.html.
  user-manage.home.stateVersion = config.system.stateVersion; # The same of the system
}
