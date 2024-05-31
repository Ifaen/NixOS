{
  pkgs,
  user,
  ...
}: {
  programs.zsh.enable = true;

  users.defaultUserShell = pkgs.zsh;
  users.users.${user.name}.useDefaultShell = true;

  environment.pathsToLink = ["/share/zsh"]; # To allow completation of zsh and bash

  home-manager.users.${user.name}.programs.zsh = {
    enable = true; # Allow home-manager to manage config file
    autosuggestion.enable = true;
  };
}
