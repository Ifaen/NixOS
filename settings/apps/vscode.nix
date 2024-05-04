{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false; # Prevent from showing message of update is available.
    mutableExtensionsDir = false;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix # Support for nix files
      #bradlc.vscode-tailwindcss # Intelligent Tailwind CSS tooling for VS Code
      christian-kohler.path-intellisense # Plugin that autocompletes filenames
      esbenp.prettier-vscode # Code formatter using prettier
      formulahendry.auto-close-tag # Automatically add HTML/XML close tag
      formulahendry.auto-rename-tag # Auto rename paired HTML/XML tag
      gruntfuggly.todo-tree # Show TODO, FIXME, etc. comment tags in a tree view
      jnoortheen.nix-ide # Nix language support with formatting and error report
      kamadorueda.alejandra # Format nix files
      file-icons.file-icons
      # ms-vscode-remote.remote-ssh # Open any folder on a remote machine using SSH and take advantage of VS Code's full feature set
      redhat.vscode-xml # Support for xml files
      redhat.vscode-yaml # Support for yaml files
      #tamasfe.even-better-toml # Support for toml files
      wix.vscode-import-cost # Display import/require package size in the editor
    ];
    userSettings = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode"; # Use prettier to format the code
      "editor.formatOnSave" = true; # Format on save
      "editor.detectIndentation" = false;

      # Font configuration
      "editor.fontFamily" = "'Fira Code Nerd Font', monospace"; # Font families
      "editor.fontLigatures" = true;

      # Change / Update the imports when file is moved / renamed
      "javascript.updateImportsOnFileMove.enabled" = "always";
      "typescript.updateImportsOnFileMove.enabled" = "always";

      "tabnine.experimentalAutoImports" = true;
      "merge-conflict.autoNavigateNextConflict.enabled" = true; # During a pull request, auto navigate to next conflict
      "npm.autoDetect" = "off";
    };
  };

  programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite."class<Code>" = "󰨞";
}
