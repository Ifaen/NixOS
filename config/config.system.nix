{
  config,
  user,
  ...
}: {
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
    kernelParams = ["intel_pstate=active"];

    loader = {
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

  system.stateVersion = "24.05"; # Before changing, read https://nixos.org/nixos/options.html.
  home-manager.users.${user.name}.home.stateVersion = config.system.stateVersion; # The same of the system
}
