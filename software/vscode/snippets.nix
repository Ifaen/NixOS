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
    };
  };
}
