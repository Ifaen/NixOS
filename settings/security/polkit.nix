{
  config,
  pkgs,
  user,
  ...
}: {
  ## POLKIT
  security = {
    polkit.enable = true; # To give super user rights to apps when required
    rtkit.enable = true; # A daemon that hands out real-time priority to processes
  };

  systemd.user.services.polkit-kde-authentication-agent-1 = {
    description = "polkit-kde-authentication-agent-1";

    wantedBy = ["graphical-session.target"];
    wants = ["graphical-session.target"];
    after = ["graphical-session.target"];

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  user.manage = {
    wayland.windowManager.hyprland.settings.windowrulev2 = [
      "stayfocused, class:(polkit-kde-authentication-agent-1)"
      "rounding 10, class:(polkit-kde-authentication-agent-1)"
    ];

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite = {
      "class<polkit-kde-authentication-agent-1>" = "󰌾 "; # nf-md-lock
    };
  };
}
