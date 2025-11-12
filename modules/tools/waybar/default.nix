{user, ...}: let
  waybar-folder = "${user.flake}/modules/tools/waybar";
in {
  user-manage.programs.waybar = {
    enable = true;

    settings.bar.include = [
      "${waybar-folder}/config.jsonc"
      # modules-left
      "${waybar-folder}/modules/custom/user.jsonc"
      "${waybar-folder}/modules/hyprland/workspaces.jsonc"
      "${waybar-folder}/modules/hyprland/window.jsonc"
      # modules-center
      "${waybar-folder}/modules/hyprland/windowcount.jsonc"
      "${waybar-folder}/modules/temperature.jsonc"
      "${waybar-folder}/modules/memory.jsonc"
      "${waybar-folder}/modules/cpu.jsonc"
      "${waybar-folder}/modules/custom/distro.jsonc"
      "${waybar-folder}/modules/idle_inhibitor.jsonc"
      "${waybar-folder}/modules/clock.jsonc"
      "${waybar-folder}/modules/network.jsonc"
      "${waybar-folder}/modules/bluetooth.jsonc"
      "${waybar-folder}/modules/custom/system_update.jsonc"
      # modules-right
      "${waybar-folder}/modules/mpris.jsonc"
      "${waybar-folder}/modules/pulseaudio.jsonc"
      "${waybar-folder}/modules/backlight.jsonc"
      "${waybar-folder}/modules/battery.jsonc"
      "${waybar-folder}/modules/custom/power_menu.jsonc"
      "${waybar-folder}/modules/custom/dividers.jsonc"
    ];

    style = ''
      @import "${waybar-folder}/style.css";
    '';
  };

  # Execute waybar on hyprland startup
  user-manage.hyprland.exec-once = ["waybar"];
}
