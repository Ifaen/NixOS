{pkgs, ...}: {
  user-manage = {
    programs.vscode = {
      enable = true;
      enableUpdateCheck = false; # Prevent from showing message of update is available.
    };

    xdg.desktopEntries.code = {
      name = "Visual Studio Code";
      exec = "code %F";
      mimeType = ["text/plain" "inode/directory"];
      categories = ["X-Rofi" "Utility" "TextEditor" "Development" "IDE"];
      icon = "vscode";
      startupNotify = true;
      terminal = false;
    };

    home.packages = [pkgs.alejandra]; # To let alejandra extension to work

    # FIXME Currently vscode is not using xdg portal file picker
    hyprland.windowrulev2 = map (rule: rule + ", class:(Code), title:(.*)(Open)(.*)") [
      "float"
      "center 1"
      "stayfocused"
      "size <60% <50%"
    ];

    waybar-workspace-icon = {
      "class<Code>" = "󰨞 ";
      "title<code>" = "";
      "title<.*Open .*>" = "";
    };
  };
}
