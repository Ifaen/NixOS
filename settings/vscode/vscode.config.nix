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

    /*
    Script to open visual studio code and move it silently to it's corresponding workspace
    because the normal way doesn't work as expected
    */
    wayland.windowManager.hyprland.settings.exec-once = [
      "${
        pkgs.writeShellScript "open-vscode-startup.sh" ''
          code &
          while ! hyprctl clients | grep -q "Visual Studio Code"; do
            sleep 0.2
          done
          hyprctl dispatch movetoworkspacesilent 2,Code
        ''
      }"
    ];

    home.packages = [pkgs.alejandra]; # To let alejandra extension to work

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite."class<Code>" = "󰨞 ";
  };
}
