{
  pkgs,
  user,
  ...
}: {
  # Yet another nix cli helper
  programs.nh = {
    enable = true;
    flake = user.flake;
  };

  user.manage = {
    # SHELLS
    programs.zsh = {
      initExtra = ''
        ${pkgs.fastfetch}/bin/fastfetch

        # Allow to use nh without putting os, also configure
        nh() {
          if [[ ($1 == "switch" || $1 == "boot") && -z "$2" ]]; then
            command nh os "$1" --ask # Always ask when updating system
          elif [[ $1 == "test" ]]; then
            command nh os test "''${@:2}" # Normal behaviour
          elif [[ $1 == "clean" && ($2 == "all" || $2 == "user" || $2 == "profile") && -z "$3" ]]; then
            command nh clean "$2" --ask # Always ask when cleaning system
          else
            command nh "$@" # Usual usage of nh
          fi
        }

        eval "$(direnv hook zsh)" # Allow to use direnv
      '';

      shellAliases = {
        l = "eza -l";
        ll = "eza -la";
        ls = "eza";
        la = "eza -a";
        lg = "eza -l | grep";
        cls = "cd $HOME && clear";
        ".." = "cd ..";
      };
    };

    # Tool to enter automatically a nix shell
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    home.packages = [pkgs.devenv];

    # A BETTER CHANGE DIRECTORY
    programs.zoxide = {
      enable = true;
      options = ["--cmd cd"];
    };

    # A BETTER LS WITH ICONS
    programs.eza = {
      enable = true;
      icons = true; # Display icons of apps or folder
      git = true; # Display if file is being tracked by git
      extraOptions = ["--no-quotes"];
    };

    # Echo information about the machine
    xdg.configFile."fastfetch/config.jsonc".text = ''
      {
        "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
        "display": {
          "separator": "  "
        },
        "modules": [
          {
            "type": "custom", // HardwareStart
            "format": "┌─────────── \u001b[1mHardware Information\u001b[0m ───────────┐" // `\u001b` is `\033`, or `\e`
          },
          {
            "type": "host",
            "key": "  󰌢"
          },
          {
            "type": "cpu",
            "key": "  󰻠"
          },
          {
            "type": "gpu",
            "key": "  󰍛"
          },
          {
            "type": "disk",
            "key": "  "
          },
          {
            "type": "memory",
            "key": "  󰑭"
          },
          {
            "type": "display",
            "key": "  󰍹"
          },
          {
            "type": "brightness",
            "key": "  󰃞"
          },
          {
            "type": "battery",
            "key": "  "
          },
          {
            "type": "poweradapter",
            "key": "  "
          },
          {
            "type": "bluetooth",
            "key": "  "
          },
          {
            "type": "sound",
            "key": "  "
          },
          {
            "type": "gamepad",
            "key": "  "
          },
          {
            "type": "custom", // SoftwareStart
            "format": "├─────────── \u001b[1mSoftware Information\u001b[0m ───────────┤"
          },
          {
            "type": "title",
            "key": "  ",
            "format": "{1}@{2}"
          },
          {
            "type": "os",
            "key": "  " // Just get your distro's logo off nerdfonts.com
          },
          {
            "type": "kernel",
            "key": "  ",
            "format": "{1} {2}"
          },
          {
            "type": "de",
            "key": "  "
          },
          {
            "type": "wm",
            "key": "  "
          },
          {
            "type": "shell",
            "key": "  "
          },
          {
            "type": "terminal",
            "key": "  "
          },
          {
            "type": "packages",
            "key": "  󰏖"
          },
          {
            "type": "wifi",
            "key": "  ",
            "format": "{4}" // ssid
          },
          {
            "type": "locale",
            "key": "  "
          },
          {
            "type": "custom", // InformationEnd
            "format": "└────────────────────────────────────────────┘"
          }
        ]
      }
    '';
  };
}
