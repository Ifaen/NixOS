{...}: {
  user-manage = {
    programs.lf = {
      enable = true;

      settings = {
        icons = true; # Enable icons
        drawbox = true; # Borders around the columns

        cursorpreviewfmt = ''\033[7m'';

        ignorecase = true; # To find files ignoring casing

        mouse = true; # Enable mouse bindings

        # To preview images using Sixel with Chafa
        preview = true;
        sixel = true;
      };
    };

    # lf to navigate, lfc to navigate and change directory on exit
    programs.zsh = {
      initExtra = ''lf() { cd "$(command lf -print-last-dir "$@")" }'';

      shellAliases.lfs = "command lf"; # lf with default behaviour
    };

    xdg.configFile."lf/icons".source = ./icons.txt;
  };
}
