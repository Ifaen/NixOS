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

    # Force nix-shell to use the $SHELL variable instead to default to bash
    initContent = ''
      nix-shell() {
        command nix-shell "$@" --run $SHELL
      }
    '';
  };

  environment.pathsToLink = ["/share/zsh"]; # To allow completation of zsh and bash
}
