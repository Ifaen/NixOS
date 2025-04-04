{user, ...}: {
  user-manage.programs.git = {
    enable = true;

    userName = user.name;
    userEmail = user.mail;

    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "code --wait"; # Used for git rebase -i and squash commits
    };
  };
}
