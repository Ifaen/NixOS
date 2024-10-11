{
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user.name}.programs.vscode.keybindings = [
    # Disable normal behaviour
    {
      key = "alt+f4";
      command = "-workbench.action.closeWindow";
    }
    {
      key = "ctrl+shift+w";
      command = "-workbench.action.closeWindow";
    }
    {
      key = "ctrl+q";
      command = "-workbench.action.quit";
    }
  ];
}
