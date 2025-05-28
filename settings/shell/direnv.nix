{pkgs, ...}: {
  user-manage = {
    # Tool to enter automatically a nix shell
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    # Allows to use direnv with zsh
    programs.zsh.initContent = ''
      eval "$(direnv hook zsh)"
    '';

    home.packages = [pkgs.devenv];
  };
}
