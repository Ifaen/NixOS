{...}: {
  networking.networkmanager.enable = true; # Enable networking

  networking.firewall.enable = true;

  # Use Cloudflare DNS
  services.resolved.enable = true;
  networking.networkmanager.dns = "systemd-resolved"; # connect both
  networking.nameservers = ["1.1.1.1"];
}
