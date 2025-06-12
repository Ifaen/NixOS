{...}: {
  user-manage.programs.vscode.profiles.default.languageSnippets = {
    nix = {
      template = {
        body = [
          "{...}: {"
          "  $0"
          "}"
        ];
        description = "Simple template for new .nix files";
        prefix = ["template"];
      };
      "brackets-option" = {
        body = [
          "{"
          "  $0"
          "};"
        ];
        description = "Add a shortcut for any new nix option";
        prefix = ["brackets-option"];
      };
    };
  };
}
