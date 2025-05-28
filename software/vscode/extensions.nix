{
  lib,
  pkgs,
  ...
}: {
  user-manage = {
    home.packages = [pkgs.alejandra];

    programs.vscode.profiles.default.extensions =
      (with pkgs.vscode-extensions; [
        jnoortheen.nix-ide # Nix language support
        kamadorueda.alejandra # Nix formatting plugin
        esbenp.prettier-vscode # General formatting plugin
        pkief.material-icon-theme # Icons
      ])
      ++
      # Extensions obtained directly from the vscode marketplace
      # NOTE: dlasagno.wal-theme is installed manually because the wal.json file is incompatible with declarative configuration
      (pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        /*
        {
          publisher = "";
          name = "";
          version = "";
          sha256 = lib.fakeSha256;
        }
        */
      ])
      # Extensions built from source
      ++ [
        # Continue extension. Allows to run local Ollama models
        pkgs.vscode-utils.buildVscodeMarketplaceExtension
        {
          mktplcRef = {
            name = "continue";
            publisher = "Continue";
            version = "1.1.40";
            sha256 = "sha256-P4rhoj4Juag7cfB9Ca8eRmHRA10Rb4f7y5bNGgVZt+E=";
            arch = "linux-x64";
          };
          nativeBuildInputs = [
            pkgs.autoPatchelfHook
          ];
          buildInputs = [pkgs.stdenv.cc.cc.lib];
        }
      ];

    programs.vscode.profiles.default.enableAutoUpdateCheck = false; # Whether to prevent auto update messages
  };

  #programs.nix-ld.enable = true;
}
