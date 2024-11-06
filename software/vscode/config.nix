{
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user.name} = {
    programs.vscode = {
      enable = true;
      enableUpdateCheck = false; # Prevent from showing message of update is available.
    };

    home.packages = [pkgs.alejandra]; # To let alejandra extension to work

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite."class<Code>" = "󰨞 ";
  };
}
