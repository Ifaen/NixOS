{lib, ...}: {
  user-manage.programs.starship = {
    enable = true;

    enableZshIntegration = true;

    settings = {
      add_newline = true;

      # Concat modules formats
      format = lib.concatStrings [
        # First line
        "$directory" # Shows the current repository
        "$git_branch$git_commit$git_status" # Shows information about the git repository
        "$cmd_duration" # Shows the duration of the command

        "$line_break" # Line break for the prompt and the command line

        # Second line
        "$nix_shell" # Shows nix-shell
        "$shell" # Shows enviroment variables
        "$character"
      ];

      # Modules
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
        min_time_to_notify = 60000 * 5; # 60000 = 1 minute
      };
      scan_timeout = 10;

      shell.disabled = false;

      nix_shell = {
        disabled = false;
        format = "via ❄️ nix-shell ";
      };
    };
  };
}
