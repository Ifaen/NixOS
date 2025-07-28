{...}: {
  imports = [
    ./hardware-configuration.nix # WARNING: INITIALLY REPLACE CONTENT WITH /etc/nixos/hardware-configuration.nix
  ];

  config = {
    # Browsers
    brave.enable = true;
    google-chrome.enable = true;

    # Tools
    olive-editor.enable = true;

    # Utilities
    ripdrag.enable = true;
  };
}
