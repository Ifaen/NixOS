{
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user.name} = {
    programs.chromium = {
      enable = true;

      package = pkgs.vivaldi;
    };

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite = {
      "class<Vivaldi-stable>" = "󰊯 ";
      "class<Brave-browser>" = " ";
    };

    home.packages = with pkgs; [
      brave # Second browser in case primary throws an error
      vdhcoapp # Companion application for the Video DownloadHelper browser add-on.
    ];
  };
}
