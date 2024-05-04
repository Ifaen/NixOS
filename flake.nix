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
    user =
      {
        fullname = "Santiago Fuentes";
        name = "sfuentes";
        home = "/home/${user.name}";
        flake = "/etc/nixos"; # Path were flake is stored
        mail = "sfuentes@mail.com";
        city = "Punta Arenas";
        system = "x86_64-linux";
      }
      // (
        if builtins.pathExists ./.is_notebook # If file exists, then is my notebook
        then {
          machine = "notebook";
          monitor = {
            name = "eDP-1";
            width = "1920";
            height = "1200";
          };
          language = "latam";
        }
        else {
          machine = "desktop";
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
          language = "us";
        }
      );
  in {
    nixosConfigurations."${user.machine}" = nixpkgs.lib.nixosSystem {
      system = user.system;
      specialArgs = {
        inherit
          user
          nur
          nixpkgs-stable
          home-manager
          xremap-flake
          ;
      };
      modules = map (path: ./settings + path) [
        /configuration.nix
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
