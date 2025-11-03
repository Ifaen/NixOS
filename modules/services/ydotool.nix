{pkgs, ...}: {
  environment.systemPackages = [pkgs.ydotool];

  # Start service for ydotool to detect inputs
  systemd.user.services.ydotoold = {
    description = "ydotool daemon";
    wantedBy = ["graphical-session.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.ydotool}/bin/ydotoold";
      ExecReload = "${pkgs.util-linux}/bin/kill -HUP $MAINPID";
      KillMode = "Process";
      Restart = "always";
      TimeoutSec = 180;
    };
  };
}
