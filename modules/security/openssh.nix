{...}: let
  port = 5432;
in {
  services.openssh = {
    enable = true;
    settings = {
      Port = port;
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  #networking.firewall = {
  #  allowedTCPPorts = [port];
  #};

  ## Prevent brute force attacks
  # Ban IP that try to connect to SSH
  services.fail2ban = {
    enable = true;
    ignoreIP = ["192.168.0.0/16"]; # Local Subnet
    maxretry = 5; # Ban IP after 5 failures
    bantime = "24h"; # Ban IPs for one day on the first ban
  };

  # SSH tarpit that slows down malicious or automated SSH connection attempts by indefinitely delaying connections
  #services.endlessh = {
  #  enable = true;
  #  port = port;
  #  openFirewall = true;
  #};
}
