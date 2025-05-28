{...}: {
  user-manage = {
    programs.vscode = {
      enable = true;

      profiles.default.enableUpdateCheck = false; # Whether to prevent messages of vscode updates
    };

    xdg.desktopEntries.code = {
      name = "Visual Studio Code";
      genericName = "VSCode";
      exec = "code %F";
      icon = "vscode";
      categories = ["X-Rofi"];
      startupNotify = true;
      settings.StartupWMClass = "code";
    };
  };
}
