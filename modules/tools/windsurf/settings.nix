{...}: {
  user-manage.programs.vscode.profiles.default.userSettings = {
    # APPAREANCE
    "editor.guides.bracketPairs" = true; # Colorize bracket pairs
    "workbench.iconTheme" = "material-icon-theme"; # Icons
    "window.menuBarVisibility" = "hidden"; # Hide menu bar
    "window.enableMenuBarMnemonics" = false;
    "window.customMenuBarAltFocus" = false;
    "editor.fontFamily" = "'Fira Code Nerd Font', monospace"; # Font families
    "editor.fontLigatures" = true;

    # UTILITIES
    "editor.multiCursorModifier" = "ctrlCmd"; # Change multi cursor keymod
    "editor.inlineSuggest.enabled" = true; # Enable inline suggestion

    # FORMATTING
    "editor.defaultFormatter" = null; # Disable default formatter
    "editor.formatOnSave" = true; # Format on save
    "editor.detectIndentation" = false; # Don't detect indentation
    "editor.tabSize" = 2; # Make the tab size to be 2 spaces

    # Language specific options
    "[javascript]" = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "javascript.updateImportsOnFileMove.enabled" = "always";
    };
    "[javascriptreact]" = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "javascript.updateImportsOnFileMove.enabled" = "always";
    };
    "[typescript]" = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "typescript.updateImportsOnFileMove.enabled" = "always";
    };
    "[typescriptreact]" = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "typescript.updateImportsOnFileMove.enabled" = "always";
    };
    "[jsonc]" = {
      "editor.defaultFormatter" = "vscode.json-language-features";
    };
    "[python]" = {
      "editor.defaultFormatter" = "ms-python.black-formatter";
      "editor.tabSize" = 4;
    };
    "nix.enableLanguageServer" = true;
    "nix.serverPath" = "nixd";
    "[nix]" = {
      "editor.defaultFormatter" = "kamadorueda.alejandra";
    };

    # DISABLED
    "npm.autoDetect" = "off"; # Turn off autodetect npm
    "workbench.startupEditor" = "none"; # Stop showing welcome page
    "extensions.ignoreRecommendations" = true; # Stop popup recommendations
    "git.confirmSync" = false; # Stop popup of git sync
    "telemetry.feedback.enabled" = false; # Disable telemetry
  };
}
