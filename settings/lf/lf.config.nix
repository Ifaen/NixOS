{
  pkgs,
  user,
  ...
}: {
  programs.thunar.enable = true; # Just when needed

  home-manager.users.${user.name} = {
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

    xdg.configFile."lf/icons".source = ./lf.icons.txt;
  };
}
