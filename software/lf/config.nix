{pkgs, ...}: {
  # -- Using thunar as a folder image previewer
  programs = {
    thunar = {
      enable = true; # Just when needed

      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
    xfconf.enable = true; # To keep preferences changes
  };

  services.tumbler.enable = true; # Thumbnail support for images

  # -- lf as terminal folder manager
  user.manage = {
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
    programs.zsh.initExtra = ''lfc() { cd "$(command lf -print-last-dir "$@")" }'';

    xdg.configFile."lf/icons".source = ./icons.txt;
  };
}
