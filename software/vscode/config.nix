{pkgs, ...}: {
  user-manage = {
    programs.vscode = {
      enable = true;
      enableUpdateCheck = false; # Prevent from showing message of update is available.
    };

    xdg.desktopEntries.code = {
      name = "Visual Studio Code";
      exec = "${pkgs.vscode}/bin/code %F";
      mimeType = ["text/plain" "inode/directory"];
      categories = ["X-Rofi" "Utility" "TextEditor" "Development" "IDE"];
      icon = "vscode";
      startupNotify = true;
      terminal = false;
    };

    home.packages = [pkgs.alejandra]; # To let alejandra extension to work

    hyprland.windowrulev2 = [
      "center 1, class:(Code), title:(.*Open .*)"
      "stayfocused, class:(Code), title:(.*Open .*)"
    ];

    waybar-workspace-icon = {
      "class<Code>" = "󰨞 ";
      "title<.*Open .*>" = "";
    };
  };
}
