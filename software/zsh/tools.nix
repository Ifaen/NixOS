{user, ...}: {
  user-manage = {
    # A better `cd` with memory
    programs.zoxide = {
      enable = true;
      options = ["--cmd cd"];
    };

    # Exclude certain paths and their subfolders
    home.sessionVariables._ZO_EXCLUDE_DIRS = builtins.concatStringsSep ":" [
      "${user.home}"
      "${user.downloads}/*"
      "${user.media}/.Secrets"
      "${user.media}/.Secrets/*"
      "${user.media}/Personal/*"
    ];

    # A better `ls` with icons
    programs.eza = {
      enable = true;
      icons = "auto"; # Display icons of apps or folder
      git = true; # Display if file is being tracked by git
      extraOptions = ["--no-quotes"];
    };
  };
}
