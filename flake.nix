{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xremap-flake.url = "github:xremap/nix-flake";

    # -- Unused (maybe for now)
    # nur.url = "github:nix-community/nur";
    # nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
  };

  outputs = {self, ...} @ inputs: let
    user = {
      fullname = "Santiago Fuentes";
      name = "sfuentes";
      mail = "sfuentes@mail.com";
      language = "us";
      system = "x86_64-linux";
      machine = "desktop";
      home = "/home/${user.name}";
      dir = {
        documents = "${user.home}/Documents";
        downloads = "${user.home}/Downloads";
        media = "${user.home}/Media";
        wallpapers = "${user.dir.media}/Wallpapers";
        recordings = "${user.dir.media}/Recordings";
        screenshots = "${user.dir.media}/Screenshots";
        flake = "${user.home}/NixOS";
        sync = "${user.home}/Sync";
        cache = "${user.home}/.cache";
        config = "${user.home}/.config";
        data = "${user.home}/.local/share";
        state = "${user.home}/.local/state";
      };
    };
  in {
    nixosConfigurations.${user.machine} = inputs.nixpkgs.lib.nixosSystem {
      system = user.system;

      specialArgs = {inherit inputs user;};

      modules = map (path: ./config + path) [
        /imports.nix
        /packages.nix
        /system.nix
        /user.nix
      ];
    };
  };
}
