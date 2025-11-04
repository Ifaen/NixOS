{user, ...}: {
  user-manage.programs.waybar = {
    enable = true;

    settings.bar.include = ["${user.flake}/modules/tools/waybar/modules.jsonc"];

    style = ''
      @import "${user.flake}/modules/tools/waybar/style.css";
    '';
  };

  user-manage.hyprland.exec-once = ["waybar"];
}
