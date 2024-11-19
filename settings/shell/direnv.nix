{pkgs, ...}: {
  user.manage = {
    # Tool to enter automatically a nix shell
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    # Allows to use direnv with zsh
    programs.zsh.initExtra = ''
      eval "$(direnv hook zsh)" # Allow to use direnv
    '';

    home.packages = [pkgs.devenv];
  };
}
