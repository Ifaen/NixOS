{pkgs, ...}: {
  user-manage = {
    home.packages = [pkgs.alejandra];

    programs.vscode.extensions = with pkgs.vscode-extensions; [
      bbenoist.nix # Nix language support
      kamadorueda.alejandra # Nix formatting plugin
      esbenp.prettier-vscode # General formatting plugin
      pkief.material-icon-theme # Icons
    ];
  };
}
