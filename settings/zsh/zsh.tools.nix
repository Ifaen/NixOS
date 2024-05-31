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

  home-manager.users.${user.name} = {
    # SHELLS
    programs.zsh = {
      initExtra = ''
        ${pkgs.fastfetch}/bin/fastfetch

        nh() {
          if [[ ($1 == "switch" || $1 == "test" || $1 == "boot") && $2 == "" ]]; then
            command nh os "$1" --ask
          elif [[ $1 == "clean" && ($2 == "all" || $2 == "user" || $2 == "profile") && $3 == "" ]]; then
            command nh clean "$2" --ask
          else
            command nh "$@"
          fi
          systemctl --user restart xremap
        }
      '';

      shellAliases = {
        stop = "systemctl --user stop";
        status = "systemctl --user status";
        restart = "systemctl --user restart";
        l = "eza -l";
        ll = "eza -la";
        ls = "eza";
        la = "eza -a";
        lg = "eza -l | grep";
        cls = "clear";
        ".." = "cd ..";
      };
    };

    # A BETTER CHANGE DIRECTORY
    programs.zoxide = {
      enable = true;
      options = ["--cmd cd"];
    };

    programs.fzf = {
      enable = true; # For cdi, which means Change Directory Interactively
    };

    # A BETTER LS WITH ICONS
    programs.eza = {
      enable = true;
      icons = true; # Display icons of apps or folder
      git = true; # Display if file is being tracked by git
      extraOptions = ["--no-quotes"];
    };

    # Echo information about the machine
    xdg.configFile."fastfetch/config.jsonc".source = ../../shared/configs/fastfetch.jsonc;
  };
}
