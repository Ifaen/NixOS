{pkgs, ...}: {
  programs.discocss = {
    enable = true;
    discordPackage = pkgs.discord.override {
      withOpenASAR = true;
      withVencord = true;
    };
  };
  programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite."class<discord>" = "";
}
