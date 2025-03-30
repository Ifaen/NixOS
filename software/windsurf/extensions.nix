{pkgs, ...}: {
  user-manage = {
    home.packages = [pkgs.alejandra];

    programs.vscode.extensions = with pkgs.vscode-extensions;
      [
        jnoortheen.nix-ide # Nix language support
        kamadorueda.alejandra # Nix formatting plugin
        esbenp.prettier-vscode # General formatting plugin
        pkief.material-icon-theme # Icons
      ]
      # Extensions obtained directly from the vscode marketplace
      # NOTE: dlasagno.wal-theme is installed manually because the wal.json file is incompatible with declarative configuration
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        /*
        {
          publisher = "";
          name = "";
          version = "";
          sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
        }
        */
      ];
  };
}
