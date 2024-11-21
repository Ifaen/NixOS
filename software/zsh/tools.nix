{...}: {
  user.manage = {
    # A better `cd` with memory
    programs.zoxide = {
      enable = true;
      options = ["--cmd cd"];
    };

    # A better `ls` with icons
    programs.eza = {
      enable = true;
      icons = true; # Display icons of apps or folder
      git = true; # Display if file is being tracked by git
      extraOptions = ["--no-quotes"];
    };
  };
}
