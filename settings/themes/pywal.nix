{pkgs, ...}: {
  user-manage = {
    programs.pywal.enable = true; # Generate and change colorschemes on the fly

    home.packages = [
      (pkgs.writeShellScriptBin "extended-pywal-schemes" ''
        source "$XDG_CACHE_HOME/wal/colors.sh"

        output_hyprland_file="$XDG_CACHE_HOME/wal/colors-hyprland.conf"
        output_rofi_file="$XDG_CACHE_HOME/wal/colors-rofi.rasi"

        > $output_hyprland_file &
        > $output_rofi_file

        colors_hyprland="\
        \$color0 = ''${color0#'#'}\n\
        \$color1 = ''${color1#'#'}\n\
        \$color2 = ''${color2#'#'}\n\
        \$color3 = ''${color3#'#'}\n\
        \$color4 = ''${color4#'#'}\n\
        \$color5 = ''${color5#'#'}\n\
        \$color6 = ''${color6#'#'}\n\
        \$color7 = ''${color7#'#'}\n\
        \$color8 = ''${color8#'#'}\n\
        \$color9 = ''${color9#'#'}\n\
        \$color10 = ''${color10#'#'}\n\
        \$color11 = ''${color11#'#'}\n\
        \$color12 = ''${color12#'#'}\n\
        \$color13 = ''${color13#'#'}\n\
        \$color14 = ''${color14#'#'}\n\
        \$color15 = ''${color15#'#'}"

        colors_rasi="* {\n\
          background: ''${background}33;\n\
          background-entry: ''${color11}80;\n\
          foreground: $foreground;\n\
          color0: $color0;\n\
          color1: $color1;\n\
          color2: $color2;\n\
          color3: $color3;\n\
          color4: $color4;\n\
          color5: $color5;\n\
          color6: $color6;\n\
          color7: $color7;\n\
          color8: $color8;\n\
          color9: $color9;\n\
          color10: $color10;\n\
          color11: $color11;\n\
          color12: $color12;\n\
          color13: $color13;\n\
          color14: $color14;\n\
          color15: $color15;\n\
        }"

        echo -e "$colors_hyprland" > $output_hyprland_file &
        echo -e "$colors_rasi" > $output_rofi_file
      '')
    ];
  };
}
