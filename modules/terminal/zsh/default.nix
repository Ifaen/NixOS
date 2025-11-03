{
  pkgs,
  user,
  ...
}: {
  # Make ZSH the default shell for users
  users.defaultUserShell = pkgs.zsh;
  users.users.${user.name}.useDefaultShell = true; # If true, the user's shell will be set to users.defaultUserShell

  programs.zsh.enable = true; # Enable zsh
  user-manage.programs.zsh.enable = true; # Allow home-manager to manage config file

  user-manage.programs.zsh = {
    autosuggestion.enable = true;

    shellAliases = {
      cls = "cd ${user.home} && clear"; # Go to home and clear
      ".." = "cd .."; # Go up one directory
    };

    # Force nix-shell to use the $SHELL variable instead to default to bash
    initContent = ''
      nix-shell() {
        command nix-shell "$@" --run $SHELL
      }
    '';
  };

  # To allow completation of zsh
  user-manage.programs.zsh.enableCompletion = true;
  environment.pathsToLink = ["/share/zsh"]; # To enable completion for system packages (e.g. systemd)

  imports = [./tools.nix];
}
