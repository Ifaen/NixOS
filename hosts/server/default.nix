{inputs, ...}: {
  imports =
    [
      ./hardware-configuration.nix # WARNING: INITIALLY REPLACE CONTENT WITH /etc/nixos/hardware-configuration.nix

      inputs.home-manager.nixosModules.home-manager # Imports home-manager as a nixos module
    ]
    ++ map (path: ../../modules + path) [
      /aliases/nixos.nix # Aliases under nixos

      /security/networking.nix # Networking
      /security/openssh.nix # Remote access

      #/services/syncthing # Synchronization tool
      #/services/wireguard.nix # VPN service

      /settings/directories.nix # XDG directories

      /terminal/zsh # Terminal shell
      /terminal/git.nix # Code version control
      /terminal/nh.nix # Nix Helper

      /utilities/power-management # Power management
    ];
}
