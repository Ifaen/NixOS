{
  pkgs,
  user,
  ...
}: let
  iconsPath = "${pkgs.wlogout}/share/wlogout/icons";
in {
  user-manage = {
    programs.wlogout = {
      enable = true;

      layout = [
        {
          label = "lock";
          action = "${pkgs.hyprlock}/bin/hyprlock --immediate";
          text = "Lock";
        }
        {
          label = "shutdown";
          action = "systemctl poweroff";
          text = "Shutdown";
        }
        {
          label = "suspend";
          action = "systemctl suspend";
          text = "Suspend";
        }
        {
          label = "reboot";
          action = "systemctl reboot";
          text = "Reboot";
        }
      ];

      style = ''
        @import "${user.home}/.cache/wal/colors-waybar.css"; /* For the color scheme */
        @import "${user.dir.flake}/software/wlogout/style.css"; /* For the styling*/

        #lock {
          background-image: image(url("${iconsPath}/lock.png"));
        }
        #suspend {
          background-image: image(url("${iconsPath}/suspend.png"));
        }
        #shutdown {
          background-image: image(url("${iconsPath}/shutdown.png"));
        }
        #reboot {
          background-image: image(url("${iconsPath}/reboot.png"));
        }
      '';
    };

    hyprland.windowrulev2 = [
      "float, class:(wlogout)"
    ];
  };
}
