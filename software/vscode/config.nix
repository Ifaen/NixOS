{
  pkgs,
  user,
  ...
}: {
  user.manage = {
    programs.vscode = {
      enable = true;
      enableUpdateCheck = false; # Prevent from showing message of update is available.
    };

    xdg.desktopEntries.vscode-rofi = {
      name = "Visual Studio Code";
      exec = "${pkgs.vscode}/bin/code %F"; # Use wayland instead of xwayland
      mimeType = ["text/plain" "inode/directory"];
      categories = ["X-Rofi" "Utility" "TextEditor" "Development" "IDE"];
      icon = "vscode";
      startupNotify = true;
      terminal = false;
    };

    home.packages = [pkgs.alejandra]; # To let alejandra extension to work

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite."class<Code>" = "󰨞 ";
  };
}
