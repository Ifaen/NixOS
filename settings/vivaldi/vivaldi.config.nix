{
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user.name} = {
    programs.chromium = {
      enable = true;

      package = pkgs.vivaldi;

      /*
      extensions = [
        {id = "oboonakemofpalcgghocfoadofidjkkk";} # KeePassXC-Browser
        {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # UBlock Origin
        {id = "mnjggcdmjocbbbhaepdhchncahnbgone";} # SponsorBlock for Youtube
        {id = "gebbhagfogifgggkldgodflihgfeippi";} # Return YouTube Dislike
      ];
      */
    };

    # Modify config files
    #xdg.configFile."vivaldi/Default/Bookmarks".source = ./vivaldi.bookmarks.json;

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite = {
      "class<Vivaldi-stable>" = "󰊯 ";
      "class<Brave-browser>" = " ";
    };

    wayland.windowManager.hyprland.settings.exec-once = ["[workspace 1 silent] vivaldi"];

    # Other browsers
    home.packages = [pkgs.brave];
  };
}
