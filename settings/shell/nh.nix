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

  # Allow to use nh without typing os
  user-manage.programs.zsh.initExtra = ''
    nh() {
      if [[ $1 == "switch" ]]; then
        command nh os switch --ask
      elif [[ $1 == "test" ]]; then
        command nh os test
      elif [[ $1 == "update" ]]; then
        command nh os test --update --ask
      elif [[ $1 == "clean" && $2 == "all" ]]; then
        command nh clean all --ask
      else
        command nh "$@"
      fi
    }
  '';
}
