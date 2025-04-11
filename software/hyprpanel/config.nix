{
  inputs,
  pkgs,
  user,
  ...
}: {
  nixpkgs.overlays = [inputs.hyprpanel.overlay]; # Add hyprpanel overlay

  user-manage = {
    programs.hyprpanel = {
      enable = true;
      hyprland.enable = true; # Autostart with hyprland
      overwrite.enable = true;

      layout = {
        "bar.layouts" = {
          "0" = {
            left = ["dashboard" "clock" "hypridle"];
            middle = ["workspaces"];
            right = ["media" "volume" "notifications"];
          };
          "1" = {
            left = ["windowtitle"];
            middle = ["workspaces"];
            right = ["volume" "systray"];
          };
        };
      };
    };

    xdg.desktopEntries.hyprpanel = {
      name = "Hyprpanel";
      exec = "${pkgs.writeShellScript "toggle-hyprpanel" ''
        if pgrep hyprpanel; then
          pkill hyprpanel
        else
          ${pkgs.hyprpanel}/bin/hyprpanel
        fi
      ''}";
      icon = "${user.flake}/software/hyprpanel/icon.png";
      categories = ["X-Rofi"];
      terminal = false;
    };
  };
}
