{
  pkgs,
  user,
  ...
}: {
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 300;
        command = "${pkgs.hyprland}/bin/hyprctl dispatch exec ${pkgs.swaylock-effects}/bin/swaylock";
      }
      {
        timeout = 500;
        command = "systemctl suspend";
      }
    ];
  };
}
