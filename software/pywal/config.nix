{pkgs, ...}: {
  user-manage = {
    programs.pywal.enable = true; # Generate and change colorschemes on the fly

    # Symlink files to .config/wal/templates, so when pywal is executed, it also uses the following templates
    xdg.configFile = {
      "wal/templates/colors-discord.css".source = ./templates/colors-discord.css; # For Vencord
      "wal/templates/colors-hyprland.conf".source = ./templates/colors-hyprland.conf; # For Hyprland
      "wal/templates/colors-rofi.rasi".source = ./templates/colors-rofi.rasi; # For Rofi
      "wal/templates/colors-kando.css".source = ./templates/colors-kando.css; # For Kando
    };
  };
}
