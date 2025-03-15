{pkgs, ...}: {
  user-manage = {
    # To use Cursor IDE (syncing with the VSCode configuration)
    home.packages = [pkgs.code-cursor];

    programs.vscode = {
      enable = true;
      enableUpdateCheck = false; # Whether to prevent from showing message of "update is available"
      mutableExtensionsDir = false; # Whether extensions can be installed or updated manually or by Visual Studio Code
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
    };
  };
}
