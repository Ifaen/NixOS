{
  description = "NixOS Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager";
    nur.url = "github:nix-community/nur";
    xremap-flake.url = "github:xremap/nix-flake";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    nur,
    xremap-flake,
  }: let
    machine = builtins.readFile ./shared/others/machine; # Read from file the machine name, desktop or notebook
    user =
      {
        fullname = "Santiago Fuentes";
        name = "sfuentes";
        home = "/home/${user.name}";
        flake = "${user.home}/NixOS";
        mail = "sfuentes@mail.com";
        city = "Punta Arenas";
        language = "us";
        system = "x86_64-linux";
        inherit machine;
      }
      // (
        if (machine == "desktop")
        then {
          monitor = {
            name = "DP-1";
            width = "1920";
            height = "1080";
          };
          monitor2 = {
            name = "HDMI-A-1";
            width = "1920";
            height = "1080";
          };
        }
        else {
          monitor = {
            name = "eDP-1";
            width = "1920";
            height = "1200";
          };
        }
      );
  in {
    nixosConfigurations.${machine} = nixpkgs.lib.nixosSystem {
      system = user.system;
      specialArgs = {
        inherit
          user
          nixpkgs-stable
          home-manager
          nur
          xremap-flake
          ;
      };
      modules = map (path: ./settings + path) [
        /config.nix
        /imports.nix
        /packages.nix
      ];
    };
    devShells.${user.system}.default = nixpkgs.legacyPackages.${user.system}.mkShell {
      nativeBuildInputs = with nixpkgs.legacyPackages.${user.system}; [
        nurl # Shows information about a package in a repository
        file # Shows information of files
      ];
    };
  };
}
