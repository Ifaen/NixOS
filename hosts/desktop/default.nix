{...}: {
  imports = [
    ./hardware-configuration.nix # WARNING: INITIALLY REPLACE CONTENT WITH /etc/nixos/hardware-configuration.nix
  ];

  config = {
    davinciResolve.enable = true;
  };
}
