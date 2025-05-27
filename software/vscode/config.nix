{
  user,
  pkgs,
  unstable-pkgs,
  ...
}: {
  user-manage = {
    home.packages = [pkgs.windsurf]; # Using windsurf instead and sync with vscode settings and extensions
    
    programs.vscode = {
      enable = true;
      profiles.default.enableUpdateCheck = false; # Whether to prevent from showing message of "update is available"
      mutableExtensionsDir = false; # Whether extensions can be installed or updated manually or by Visual Studio Code
    };

    xdg.desktopEntries.windsurf = {
      name = "Windsurf";
      exec = "windsurf --ozone-platform=wayland %F"; # Launch Windsurf with wayland support
      icon = "windsurf";
      categories = ["X-Rofi"];
      startupNotify = true;
      settings.StartupWMClass = "windsurf";
    };
  };
}
