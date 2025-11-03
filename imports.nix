# TODO: Move all imports in here
{inputs, ...}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager # Imports home-manager as a nixos module
    inputs.nur.modules.nixos.default # Adds the NUR overlay

    ./modules/browsers/brave # Brave browser
    ./modules/browsers/google-chrome # Google Chrome browser
    ./modules/browsers/mullvad # Mullvad browser
    ./modules/tools/olive-editor # Video editor
    ./modules/tools/dupeguru # Duplicate file finder
    ./modules/utilities/ripdrag # Drag and drop application
    ./modules/services/mako # Notification daemon
    ./modules/services/wireguard # VPN service
    ./modules/utilities/power-management # Power management
  ];
}
