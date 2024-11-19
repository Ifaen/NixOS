{user, ...}: {
  services.getty.autologinUser = user.name; # Autologin

  # Autostart Hyprland upon a new session shell is initialized in tt1
  user.manage.programs.zsh.profileExtra = ''
    if [ "$(tty)" = "/dev/tty1" ]; then
      exec Hyprland
    fi
  '';
}
