{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false; # Prevent from showing message of update is available.

    userSettings = {
      # APPAREANCE
      "editor.guides.bracketPairs" = true; # Colorize bracket pairs
      "workbench.iconTheme" = "file-icons"; # Icons
      # Hide menu bar
      "window.menuBarVisibility" = "hidden";
      "window.enableMenuBarMnemonics" = false;
      "window.customMenuBarAltFocus" = false;
      # Font configuration
      "editor.fontFamily" = "'Fira Code Nerd Font', monospace"; # Font families
      "editor.fontLigatures" = true;

      # UTILITIES
      "editor.multiCursorModifier" = "ctrlCmd"; # Change multi cursor keymod
      #Formatting
      "editor.defaultFormatter" = "esbenp.prettier-vscode"; # Use prettier to format the code
      "editor.formatOnSave" = true;
      "editor.detectIndentation" = false;
      # Change / Update the imports when file is moved / renamed
      "javascript.updateImportsOnFileMove.enabled" = "always";
      "typescript.updateImportsOnFileMove.enabled" = "always";

      # DISABLED
      "npm.autoDetect" = "off"; # Turn off autodetect npm
      "workbench.startupEditor" = "none"; # Stop showing welcome page
      "extensions.ignoreRecommendations" = true; # Stop popup recommendations
      "git.confirmSync" = false; # Stop popup of git sync
    };

    keybindings = [
      {
        key = "alt+f4";
        command = "-workbench.action.closeWindow";
      }
      {
        key = "ctrl+shift+w";
        command = "-workbench.action.closeWindow";
      }
    ];
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

  programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite."class<Code>" = "󰨞";

  home.packages = [pkgs.alejandra]; # To let alejandra extension to work
}
