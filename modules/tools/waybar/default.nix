{user, ...}: {
  user-manage.programs.waybar = {
    enable = true;

    settings.bar.include = ["${user.flake}/software/waybar/modules.jsonc"];

    style = ''
      @import "${user.flake}/software/waybar/style.css";
    '';
  };

  user-manage.hyprland.exec-once = ["waybar"];
}
