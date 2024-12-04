{
  pkgs,
  user,
  ...
}: {
  # Yet another nix cli helper
  programs.nh = {
    enable = true;
    flake = user.dir.flake;
  };

  # Allow to use nh without typing os
  user.manage.programs.zsh.initExtra = ''
    nh() {
      if [[ ($1 == "switch" || $1 == "boot") && -z "$2" ]]; then
        command nh os "$1" --ask
      elif [[ $1 == "test" ]]; then
        command nh os test "''${@:2}"
        ${pkgs.libnotify}/bin/notify-send "Testing changes applied" -t 2500
      elif [[ $1 == "clean" && ($2 == "all" || $2 == "user" || $2 == "profile") && -z "$3" ]]; then
        command nh clean "$2" --ask
      else
        command nh "$@"
      fi
    }
  '';
}
