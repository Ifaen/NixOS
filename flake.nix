{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/nur";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    xremap-flake.url = "github:xremap/nix-flake";
    hyprpanel.url = "github:Ifaen/HyprPanel"; # Hyprpanel fork of hyprpanel.url = "github:jas-singhfsu/hyprpanel";
  };

  outputs = {self, ...} @ inputs: let
    user = {
      fullname = "Santiago Fuentes";
      name = "sfuentes";
      mail = "dev@sfuentes.cl";
      system = "x86_64-linux";

      # -- Directories
      home = "/home/${user.name}";
      flake = "${user.home}/NixOS";
      documents = "${user.home}/Documents";
      downloads = "${user.home}/Downloads";
      media = "${user.home}/Media";
      sync = "${user.home}/Sync";
      wallpapers = "${user.media}/Wallpapers";
      recordings = "${user.media}/Recordings";
      screenshots = "${user.media}/Screenshots";
      cache = "${user.home}/.cache";
      config = "${user.home}/.config";
      data = "${user.home}/.local/share";
      state = "${user.home}/.local/state";
    };
  in {
    nixosConfigurations = {
      desktop = inputs.nixpkgs.lib.nixosSystem {
        system = user.system;

        specialArgs = {
          inherit inputs;

          user = user // {machine = "desktop";};
        };

        modules = map (path: ./modules + path) [
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
