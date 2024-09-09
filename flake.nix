{
  description = "NixOS Flake";

  inputs = {
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixpkgs.url = "nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/nur";
    ags.url = "github:Aylur/ags";
    xremap-flake.url = "github:xremap/nix-flake";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    nur,
    ags,
    xremap-flake,
  }: let
    user = {
      fullname = "Santiago Fuentes";
      name = "sfuentes";
      home = "/home/${user.name}";
      flake = "${user.home}/NixOS";
      mail = "sfuentes@mail.com";
      language = "us";
      system = "x86_64-linux";
      machine = "desktop";
      monitor = "HDMI-A-1";
    };
  in {
    nixosConfigurations.${user.machine} = nixpkgs.lib.nixosSystem {
      system = user.system;

      specialArgs = {
        inherit
          user
          nixpkgs-unstable
          home-manager
          nur
          ags
          xremap-flake
          ;
      };

      modules = map (path: ./settings + path) [
        /config.nix
        /imports.nix
        /packages.nix
      ];
    };
  };
}
