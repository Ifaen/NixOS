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

    # Autostart Hyprland upon a new session shell is initialized in tt1
    profileExtra = ''
      if [ "$(tty)" = "/dev/tty1" ]; then
        exec Hyprland
      fi
    '';
  };
}
