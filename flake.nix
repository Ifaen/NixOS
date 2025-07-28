{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/nur";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    xremap-flake.url = "github:xremap/nix-flake";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = {...} @ inputs: let
    systemFor = hostname:
      inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;

          user = rec {
            fullname = "Santiago Fuentes";
            name = "sfuentes";
            mail = "dev@sfuentes.cl";
            inherit hostname;

            # -- Directories
            home = "/home/${name}";
            flake = "${home}/NixOS";
            documents = "${home}/Documents";
            downloads = "${home}/Downloads";
            sync = "${home}/Sync";
            wallpapers = "${documents}/Wallpapers";
            recordings = "${documents}/Recordings";
            screenshots = "${documents}/Screenshots";
            cache = "${home}/.cache";
            config = "${home}/.config";
            data = "${home}/.local/share";
            state = "${home}/.local/state";
          };
        };

        modules = [
          ./imports.nix
          ./hosts/${hostname} # TODO: Have toggles of each module for a more modular configuration, replacing imports.nix
          ./modules/imports.nix # TODO: Remove this after the previous TODO is done
          ./modules/packages.nix
          ./modules/system.nix
          ./modules/user.nix
        ];
      };
  in {
    nixosConfigurations = {
      desktop = systemFor "desktop";
      notebook = systemFor "notebook";
    };
  };
}
