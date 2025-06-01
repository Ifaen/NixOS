{
  pkgs,
  user,
  ...
}: {
  user-manage = {
    home.packages = [
      pkgs.kando
      pkgs.gnomeExtensions.kando-integration # Allows kando to work in wayland
    ];

    hyprland = {
      exec-once = ["kando"];

      windowrulev2 = map (rule: rule + ", class:(kando)") [
        "float"
        "pin"
        "size 100% 100%"
        "noblur"
        "noborder"
        "noanim"
        "opaque"
        "stayfocused"
      ];

      bind = ["super, super_l, exec, kando --menu 'HexMenu'"];
      bindo = ["super, super_l, exec, nothing"]; # On purpose to have a way to only allow menu on short press
    };

    # Symlink files
    xdg.configFile = {
      # Hexperiment
      "kando/menu-themes/hexperiment/theme.json5".source = ./menu-themes/hexperiment/theme.json5;
      "kando/menu-themes/hexperiment/REUSE.toml".source = ./menu-themes/hexperiment/REUSE.toml;
      "kando/menu-themes/hexperiment/border.svg".source = ./menu-themes/hexperiment/border.svg;
      "kando/menu-themes/hexperiment/preview.jpg".source = ./menu-themes/hexperiment/preview.jpg;
      # This way allows to work with pywal while being compatible with nixos
      "kando/menu-themes/hexperiment/theme.css".text = ''
        @import "${user.cache}/wal/colors-kando.css";
        @import "${user.flake}/software/kando/menu-themes/hexperiment/theme.css";
      '';
    };
  };
}
