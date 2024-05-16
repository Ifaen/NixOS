{
  pkgs,
  user,
  ...
}: {
  # https://sunnnychan.github.io/cheatsheet/linux/config/alacritty.yml.html
  programs.alacritty = {
    enable = true;
    settings = {
      shell = "${pkgs.zsh}/bin/zsh";
      font = {
        size = 12;
      };
      scrolling.history = 100000;
      window = {
        opacity = 0.6;
        padding = {
          x = 15;
          y = 15;
        };
      };
    };
  };

  wayland.windowManager.hyprland.settings.exec-once =
    [
      "[workspace 11 silent] alacritty"
    ]
    ++ (
      if user.machine == "desktop"
      then [
        "[workspace 3 silent] alacritty"
      ]
      else []
    );

  programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite."class<Alacritty>" = "󰆍";
}
