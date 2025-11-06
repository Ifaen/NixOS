{
  inputs,
  pkgs,
  ...
}: {
  imports =
    [
      ./hardware-configuration.nix # WARNING: INITIALLY REPLACE CONTENT WITH /etc/nixos/hardware-configuration.nix

      inputs.home-manager.nixosModules.home-manager # Imports home-manager as a nixos module
    ]
    ++ map (path: ../../modules + path) [
      /aliases/nixos.nix # Aliases under nixos

      /security/networking.nix # Networking
      #/security/openssh.nix # Remote access

      #/services/syncthing # Synchronization tool
      #/services/wireguard.nix # VPN service
      /services/tailscale.nix # Tailscale services for remote access

      /settings/directories.nix # XDG directories

      /terminal/zsh # Terminal shell
      /terminal/git.nix # Code version control
      /terminal/nh.nix # Nix Helper

      /utilities/auto-cpufreq.nix # Change the CPU governor based on the power source
    ];

  config = {
    # Make sure to disable Bluetooth and sound
    hardware.bluetooth.enable = false;
    services.pipewire.enable = false;

    # Prevent suspend, hibernate, and hybrid sleep
    systemd.sleep.extraConfig = ''
      AllowSuspend=no
      AllowHibernation=no
      AllowHybridSleep=no
    '';

    # Enable tlp for power management
    services.tlp.enable = true;
  };
}
