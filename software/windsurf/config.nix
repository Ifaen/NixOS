{
  pkgs,
  unstable-pkgs,
  ...
}: {
  user-manage = {
    # To use Cursor IDE (syncing with the VSCode configuration)
    home.packages = [
      pkgs.code-cursor
      unstable-pkgs.windsurf
    ];

    programs.vscode = {
      enable = true;
      enableUpdateCheck = false; # Whether to prevent from showing message of "update is available"
      mutableExtensionsDir = false; # Whether extensions can be installed or updated manually or by Visual Studio Code

      #package = pkgs.windsurf; # FIXME: Wait until next home-manager update
    };

    xdg.desktopEntries = {
      cursor = {
        name = "Cursor IDE";
        exec = "cursor --ozone-platform=wayland --no-sandbox %U";
        icon = "cursor";

        categories = ["X-Rofi" "Utility" "TextEditor" "Development" "IDE"];
        mimeType = ["text/plain" "inode/directory"];
        terminal = false;
        startupNotify = true;
      };

      windsurf = {
        name = "Windsurf";
        exec = "windsurf --ozone-platform=wayland %F";
        icon = "windsurf";

        categories = ["X-Rofi" "Utility" "TextEditor" "Development" "IDE"];
        startupNotify = true;
        settings.StartupWMClass = "windsurf";

        terminal = false;
      };
    };
  };
}
