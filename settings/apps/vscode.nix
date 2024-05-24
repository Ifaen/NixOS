{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false; # Prevent from showing message of update is available.

    userSettings = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode"; # Use prettier to format the code
      "editor.formatOnSave" = true;
      "editor.detectIndentation" = false;

      # Font configuration
      "editor.fontFamily" = "'Fira Code Nerd Font', monospace"; # Font families
      "editor.fontLigatures" = true;

      # Change / Update the imports when file is moved / renamed
      "javascript.updateImportsOnFileMove.enabled" = "always";
      "typescript.updateImportsOnFileMove.enabled" = "always";

      "merge-conflict.autoNavigateNextConflict.enabled" = true; # During a pull request, auto navigate to next conflict
      "npm.autoDetect" = "off"; # Turn off autodetect npm
      "workbench.iconTheme" = "file-icons"; # Icons
      "workbench.startupEditor" = "none";
      "window.menuBarVisibility" = "hidden";
      "window.enableMenuBarMnemonics" = false;
      "window.customMenuBarAltFocus" = false;
    };

    /*
       keybindings = [{
      key = "ctrl";
      command = "workbench.action.toggleMenuBar";
      #when = "";
    }];
    */
  };

  programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite."class<Code>" = "󰨞";

  home.packages = [pkgs.alejandra];
}
