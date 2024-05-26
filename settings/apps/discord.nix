{pkgs, ...}: {
  home = {
    packages = [pkgs.discord-screenaudio];
    file.discordcss = {
      target = ".config/discord-screenaudio/userstyles.css";
      text = "";
    };
  };
  programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite."class<discord>" = "";
}
