{
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user.name}.programs.vscode.extensions = with pkgs.vscode-extensions; [
    bbenoist.nix # Nix language support
    kamadorueda.alejandra # Nix formatting plugin
    esbenp.prettier-vscode # General formatting plugin
    equinusocio.vsc-material-theme-icons # Icons
  ];
}
