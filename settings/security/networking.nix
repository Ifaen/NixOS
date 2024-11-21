{...}: {
  networking.networkmanager.enable = true; # Enable networking

  networking.firewall = {
    enable = true;
  };
}
