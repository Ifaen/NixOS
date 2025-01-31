{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xremap-flake.url = "github:xremap/nix-flake";
  };

  outputs = {self, ...} @ inputs: let
    user = {
      fullname = "Santiago Fuentes";
      name = "sfuentes";
      mail = "dev@sfuentes.cl";
      language = "us";
      system = "x86_64-linux";
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
    nixosConfigurations = {
      desktop = inputs.nixpkgs.lib.nixosSystem {
        system = user.system;

        specialArgs = {
          inherit inputs;

          user = user // {machine = "desktop";};
        };

        modules = map (path: ./config + path) [
          /imports.nix
          /packages.nix
          /system.nix
          /user.nix
        ];
      };

      notebook = inputs.nixpkgs.lib.nixosSystem {
        system = user.system;

        specialArgs = {
          inherit inputs;

          user = user // {machine = "notebook";};
        };

        modules = map (path: ./modules + path) [
          /imports.nix
          /system.nix
          /user.nix
        ];
      };
    };
  };
}
