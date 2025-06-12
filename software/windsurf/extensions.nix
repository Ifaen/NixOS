{pkgs, ...}: {
  user-manage = {
    home.packages = [pkgs.alejandra]; # Needed for extension to work correctly

    programs.vscode.profiles.default.extensions =
      (with pkgs.vscode-extensions; [
        jnoortheen.nix-ide # Nix language support
        kamadorueda.alejandra # Nix formatting plugin
        esbenp.prettier-vscode # General formatting plugin
        pkief.material-icon-theme # Icons
      ])
      # NOTE: dlasagno.wal-theme is installed manually because the wal.json file is incompatible with declarative configuration
      # Extensions obtained directly from marketplace. Used sha256=pkgs.lib.fakeSha256; to get the correct sha256
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        # Toggle settings.json "files.exclude" option
        {
          name = "toggle-excluded-files";
          publisher = "amodio";
          version = "2023.4.1012";
          sha256 = "sha256-j0zAAnaGIzKTlt8QXvaEGwRb8dWnGkcB/2/XVH+lHXQ=";
        }
      ];

    programs.vscode.profiles.default.enableExtensionUpdateCheck = false; # Whether to prevent auto update messages
  };
}
