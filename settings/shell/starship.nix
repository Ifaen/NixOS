{
  lib,
  user,
  ...
}: {
  home-manager.users.${user.name}.programs.starship = {
    enable = true;

    settings = {
      add_newline = true;

      format = lib.concatStrings [
        "$directory" # Shows the current repository
        "$git_branch$git_commit$git_status" # Shows information about the git repository
        "$cmd_duration" # Shows the duration of the command
        "$line_break" # Line break for the prompt and the command line
        "$sudo" # Displays if sudo credentials are currently cached
        "$shell" # Shows enviroment variables
        "$character"
      ];

      directory = {
        format = lib.concatStrings [
          "$read_only"
          "$path "
        ];
        read_only = "🔒";
      };

      character = {
        success_symbol = "❯";
        error_symbol = "✖";
      };

      cmd_duration = {
        show_notifications = true;
        min_time_to_notify = 60000 * 5;
      };
      scan_timeout = 10;

      shell.disabled = false;

      sudo.disabled = false;
    };
  };
}
