{pkgs, ...}: {
  user-manage = {
    programs.vscode = {
      enable = true;
      package = pkgs.windsurf; # Use Windsurf instead of VSCode
      profiles.default.enableUpdateCheck = false; # Whether to prevent messages of vscode updates
    };

    xdg.desktopEntries.windsurf = {
      name = "Windsurf";
      genericName = "vscode";
      exec = "env NIXOS_OZONE_WL=1 windsurf %F";
      icon = "code";
      categories = ["X-Rofi"];
      startupNotify = true;
      settings.StartupWMClass = "windsurf";
    };

    xdg.mimeApps.defaultApplications = {
      "application/json" = "windsurf.desktop";
      "application/x-httpd-php" = "windsurf.desktop";
      "application/xml" = "windsurf.desktop";
    };
  };

  imports = [
    ./settings.nix
    ./extensions.nix
    ./keybinds.nix
    ./snippets.nix
  ];
}
