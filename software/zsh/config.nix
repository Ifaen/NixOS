{
  pkgs,
  user,
  ...
}: {
  programs.zsh.enable = true;

  user-configuration.useDefaultShell = true;

  users.defaultUserShell = pkgs.zsh;

  user-manage.programs.zsh = {
    enable = true; # Allow home-manager to manage config file
    autosuggestion.enable = true;

    shellAliases = {
      cls = "cd ${user.home} && clear";
      ".." = "cd ..";
    };
  };

  environment.pathsToLink = ["/share/zsh"]; # To allow completation of zsh and bash
}
