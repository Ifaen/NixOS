{...}: {
  user-manage.programs.vscode.userSettings = {
    # APPAREANCE
    "editor.guides.bracketPairs" = true; # Colorize bracket pairs
    "workbench.iconTheme" = "material-icon-theme"; # Icons
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
}
