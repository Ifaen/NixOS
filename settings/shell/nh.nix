{
  pkgs,
  user,
  ...
}: {
  # Yet another nix cli helper
  programs.nh = {
    enable = true;
    flake = user.flake;
  };

  # Modify nh commands to be opinionated
  user-manage.programs.zsh.initExtra = ''
    nh() {
      if [[ $1 == "test" ]]; then
        sudo -n true 2>/dev/null || sudo -v || return 1
        command nh os test "''${@:2}"
      elif [[ $1 == "update" ]]; then
        command nh os test --update --ask
      elif [[ ($1 == "switch" || $1 == "boot") && -z "$2" ]]; then
        command nh os "$1" --ask
      elif [[ $1 == "clean" && -z "$2" ]]; then
        command nh clean all --ask
      else
        command nh "$@"
      fi
    }
  '';
}
