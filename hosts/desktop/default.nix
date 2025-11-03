{...}: {
  imports = [
    ./hardware-configuration.nix # WARNING: INITIALLY REPLACE CONTENT WITH /etc/nixos/hardware-configuration.nix
  ];

  config = {
    # Browsers
    brave.enable = true;
    google-chrome.enable = true;
    mullvad-browser.enable = true;

    # Tools
    olive-editor.enable = true;
    dupeguru.enable = true;

    # Utilities
    ripdrag.enable = true;
    power-management.enable = true;

    # Services
    mako.enable = true;
    wireguard.enable = true;
  };
}
