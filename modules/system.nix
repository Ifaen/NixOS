{
  lib,
  config,
  user,
  ...
}: {
  config =
    {
      # Enable flakes and auto optimise /nix/store
      nix.settings = {
        experimental-features = ["nix-command" "flakes"];
        auto-optimise-store = true;
      };

      nixpkgs.config.allowUnfree = true; # Allows unfree packages for nixpkgs

      networking.hostName = user.machine; # Hostname of system

      home-manager = {
        useUserPackages = false; # If true, moves the home-manager packages from $HOME/.nix-profile to /etc/profiles
        useGlobalPkgs = true; # To use the same nixpkgs configuration as the nixos system

        backupFileExtension = "backup";
      };

      system.stateVersion = "24.05"; # Before changing, read https://nixos.org/nixos/options.html.
      user-manage.home.stateVersion = config.system.stateVersion; # The same of the system
    }
    // (
      if (user.machine == "wsl")
      then {
        wsl = {
          enable = true;

          defaultUser = user.name; # Default: "nixos"
          wslConf.user.default = user.name; # Which user to start commands in this WSL distro as. Default: "root"

          useWindowsDriver = true; # Use OpenGL from windows

          startMenuLaunchers = true; # Whether to enable shortcuts for GUI applications in the windows start menu
        };

        environment.sessionVariables.DONT_PROMPT_WSL_INSTALL = 1; # Disable prompt for apps that are installed under wsl and not windows
      }
      else {
        users = {
          mutableUsers = false; # Prevents to create or modify new users besides the declared

          users.root.hashedPassword = "!"; # Disable root user
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

        boot = {
          loader = {
            grub =
              {
                enable = true;

                devices = ["nodev"];

                efiSupport = true;
              }
              // lib.optionalAttrs (user.machine == "desktop") {
                useOSProber = true; # Append entries for other OSs detected by os-prober
              };

            efi.canTouchEfiVariables = true;

            timeout = 100;
          };

          tmp.cleanOnBoot = true;
        };
      }
    );
}
