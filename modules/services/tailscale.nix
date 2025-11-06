{config, user, ...}:{
  services.tailscale = {
    enable = true;
    extraUpFlags = if user.hostname == "server" then ["--ssh"] else [];
  };

  networking.firewall = {
    # allow all ports from your Tailscale network
    trustedInterfaces = [ "tailscale0" ];

    # allow the Tailscale UDP port through the firewall
    allowedUDPPorts = [ config.services.tailscale.port ];
  };
}