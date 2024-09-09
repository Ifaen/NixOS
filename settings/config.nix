{
  config,
  pkgs,
  nixpkgs-unstable,
  nur,
  home-manager,
  xremap-flake,
  user,
  ...
}: {
  imports = [home-manager.nixosModules.home-manager]; # import the HM system module *once*

  # Enable flakes and auto optimise /nix/store
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;
    trusted-users = ["${user.name}"];
  };

  # Enable the usage of NUR and Stable packages globally, with unfree configuration
  nixpkgs.overlays = [
    nur.overlay # Already allows unfree packages in it's own flake
    # Unstable Overlay
    (final: prev: {
      unstable = import nixpkgs-unstable {
        system = user.system;
        config.allowUnfree = true; # Allow unfree packages for unstable nixpkgs
      };
    })
  ];
  nixpkgs.config.allowUnfree = true; # Allow unfree packages for nixpkgs

  networking.hostName = user.machine; # Define your hostname.

  time.timeZone = "America/Santiago"; # Set your time zone.

  users = {
    mutableUsers = false;
    users = {
      "${user.name}" = {
        description = "${user.fullname}";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        hashedPassword = "$6$mPfCRmBsa0vLp6Hl$kw2/2SpSr9UdqzZ65.4/D0cmgyERlhy0VM.OS8KHmdc5bZW2CY7oyz8JZL2hp1yBi2FIkeJdjFdyI9ketviG11"; # To generate a hashed password run mkpasswd
        isNormalUser = true;
      };
      root.hashedPassword = "!"; # Disable root user
    };
  };

  system.stateVersion = "24.05"; # Before changing, read https://nixos.org/nixos/options.html.

  home-manager = {
    useUserPackages = true; # True to move the home-manager packages to /etc/profiles instead of $HOME/.nix-profile
    useGlobalPkgs = true; # True to use the same nixpkgs config as the nixos system

    users.${user.name} = {
      programs.home-manager.enable = true; # Let Home Manager install and manage itself.

      home = {
        username = user.name;
        homeDirectory = user.home;
        stateVersion = config.system.stateVersion; # The same of the system
      };
    };
  };

  boot = {
    kernelParams = ["intel_pstate=active"];

    loader = {
      #systemd-boot.enable = true;
      grub = {
        enable = true;
        devices = ["nodev"];
        efiSupport = true;
        useOSProber = true;
      };
      efi.canTouchEfiVariables = true;
      timeout = 100;
    };

    tmp.cleanOnBoot = true;
  };

  # Configure console keymap
  console.keyMap = "${user.language}";

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
}
