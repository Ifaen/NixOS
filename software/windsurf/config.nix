{
  pkgs,
  unstable-pkgs,
  ...
}: {
  user-manage = {
    # To use Windsurf (syncing with the VSCode configuration)
    home.packages = [unstable-pkgs.windsurf];

    programs.vscode = {
      enable = true;
      enableUpdateCheck = false; # Whether to prevent from showing message of "update is available"
      mutableExtensionsDir = false; # Whether extensions can be installed or updated manually or by Visual Studio Code

      #package = pkgs.windsurf; # FIXME: Wait until next home-manager update
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
