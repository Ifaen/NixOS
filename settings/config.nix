{
  config,
  pkgs,
  nixpkgs-stable,
  nur,
  home-manager,
  xremap-flake,
  user,
  ...
}: let
  stateVersion = "23.11"; # Before changing, read https://nixos.org/nixos/options.html.
in {
  imports = [home-manager.nixosModules.home-manager]; # import the HM system module *once*

  # Enable flakes and auto optimise /nix/store
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      trusted-users = ["${user.name}"];
    };
    extraOptions = ''
      warn-dirty = false
    '';
  };

  # Enable the usage of NUR and Stable packages globally, with unfree configuration
  nixpkgs.overlays = [
    nur.overlay # Already allows unfree packages in it's own flake
    # Stable Overlay
    (final: prev: {
      stable = import nixpkgs-stable {
        system = user.system;
        config.allowUnfree = true; # Allow unfree packages for stable nixpkgs
      };
    })
  ];
  nixpkgs.config.allowUnfree = true; # Allow unfree packages for nixpkgs

  networking.hostName = user.machine; # Define your hostname.

  users = {
    mutableUsers = false;
    users = {
      ${user.name} = {
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

  home-manager = {
    useUserPackages = true; # True to move the home-manager packages to /etc/profiles instead of $HOME/.nix-profile
    useGlobalPkgs = true; # True to use the same nixpkgs config as the nixos system

    users.${user.name} = {
      programs.home-manager.enable = true; # Let Home Manager install and manage itself.

      home = {
        username = user.name;
        homeDirectory = user.home;
        inherit stateVersion;
      };
    };

    extraSpecialArgs = {inherit user;};

    backupFileExtension = "bak";
  };

  boot = {
    kernelParams = [
      "intel_pstate=active"
    ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  system = {
    inherit stateVersion;
  };
}
