{
  lib,
  pkgs,
  ...
}: {
  user-manage = {
    home.packages = [pkgs.alejandra]; # Needed for extension to work correctly

    programs.vscode.profiles.default.extensions = let
      # NOTE: dlasagno.wal-theme is installed manually because the wal.json file is incompatible with declarative configuration
      # Extensions built from source. Used sha256=lib.fakeSha256; to get the correct sha256
      continue =
        pkgs.vscode-utils.buildVscodeMarketplaceExtension
        {
          mktplcRef = {
            name = "continue";
            publisher = "Continue";
            version = "1.1.40";
            sha256 = "sha256-P4rhoj4Juag7cfB9Ca8eRmHRA10Rb4f7y5bNGgVZt+E=";
            arch = "linux-x64";
          };
          # Patch obtained from: https://github.com/continuedev/continue/issues/821
          nativeBuildInputs = [pkgs.autoPatchelfHook];
          buildInputs = [pkgs.stdenv.cc.cc.lib];
        };
    in
      (with pkgs.vscode-extensions; [
        jnoortheen.nix-ide # Nix language support
        kamadorueda.alejandra # Nix formatting plugin
        esbenp.prettier-vscode # General formatting plugin
        pkief.material-icon-theme # Icons
      ])
      ++ [
        continue # Continue extension. Allows to run local Ollama models
      ];

    programs.vscode.profiles.default.enableExtensionUpdateCheck = false; # Whether to prevent auto update messages
  };
}
