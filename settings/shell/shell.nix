{
  pkgs,
  user,
  ...
}: let
  shellAliases = {
    stop = "systemctl --user stop";
    status = "systemctl --user status";
    restart = "systemctl --user restart";
    l = "eza -l";
    ll = "eza -la";
    ls = "eza";
    la = "eza -a";
    lg = "eza -l | grep";
    lf = "ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd \"$LASTDIR\"";
    cls = "clear";
    ".." = "cd ..";
  };
in {
  users.defaultUserShell = pkgs.zsh;

  environment.pathsToLink = ["/share/zsh"];

  programs.zsh.enable = true; # Enable zsh in PATH

  home-manager.users.${user.name} = {
    # SHELLS
    programs.zsh = {
      enable = true; # Allow home-manager to manage config file
      autocd = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      initExtra = "fastfetch";
      inherit shellAliases;
    };
    programs.bash = {
      enable = true;
      inherit shellAliases;
    };
    # A BETTER CHANGE DIRECTORY
    programs.zoxide = {
      enable = true;
      options = [
        "--cmd cd"
      ];
    };
    programs.fzf = {
      enable = true; # For cdi, which means Change Directory Interactively
    };
    # A BETTER LS WITH ICONS
    programs.eza = {
      enable = true;
      icons = true; # Display icons of apps or folder
      git = true; # Display if file is being tracked by git
      extraOptions = [
        "--no-quotes"
      ];
    };
    # Packages used in the shell
    home.packages = with pkgs; [
      fastfetch # Echo information about the machine
      nix-output-monitor # Frontend output for performing certain nix commands. Can be used as 'nom develop' or 'nom shell'
    ];
    home.file.fastfetch = {
      enable = true;
      source = ../../shared/configs/fastfetch.jsonc;
      target = "${user.home}/.config/fastfetch/config.jsonc";
    };
  };
}
