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
      # Don't store secrets and passwords in zoxide
      "${user.documents}/.Secrets"
      "${user.documents}/.Secrets/*"
      # Don't store personal data in zoxide
      "${user.documents}/Personal/*"
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
