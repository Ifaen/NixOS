{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    xremap-flake.url = "github:xremap/nix-flake";
    nix-tagstudio.url = "github:zierf/TagStudio/poetry2nix"; # https://github.com/TagStudioDev/TagStudio/issues/200
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    # nur.url = "github:nix-community/nur"; # -- Unused (maybe for now)
  };

  outputs = {self, ...} @ inputs: let
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
    nixosConfigurations.${user.machine} = inputs.nixpkgs.lib.nixosSystem {
      system = user.system;

      specialArgs = {inherit inputs user;};

      modules = map (path: ./config + path) [
        /imports.nix
        /config.system.nix
        /config.user.nix
        /packages.nix
      ];
    };
  };
}
