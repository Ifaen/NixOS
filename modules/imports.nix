{
  config,
  lib,
  inputs,
  user,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager # Imports home-manager as a nixos module
      inputs.nur.modules.nixos.default # Adds the NUR overlay
    ]
    ++ map (path: ../settings + path) [
      /aliases/home-manager.nix # Aliases under home-manager
      /aliases/nixos.nix # Aliases under nixos

      /hardware/drivers.nix # Few drivers, depending of the hardware

      /security/hyprlock.nix # System password lock
      /security/keepassxc.nix # Password manager
      /security/networking.nix # Networking
      /security/polkit.nix # Policy kit (to grant system privileges to user)

      /services/directories.nix # XDG directories
      /services/getty.nix # Autologin in TTY1
      /services/hypridle.nix # Idle management daemon
      /services/pipewire.nix # Every sound related service
      /services/portal.nix # XDG desktop portal
      /services/udisks2.nix # Allows applications to query and manipulate storage devices

      /shell/direnv.nix # Tool to automatically enter a nix-shell
      /shell/git.nix # Code version control
      /shell/nh.nix # Nix Helper
      /shell/starship.nix # Shell prompt

      /themes/fonts.nix # Characters fonts
      /themes/gtk.nix # GTK Toolkit configuration
      /themes/hyprcursor.nix # Cursor
      /themes/qt.nix # QT Toolkit configuration
      /themes/waypaper.nix # Wallpaper manager
    ]
    ++ map (path: ../software + path) [
      /firefox # Web Browser
      /hyprland # Window manager
      /kando # App / Menu Launcher
      /kitty # Terminal emulator
      /lf # Terminal file manager
      /pywal # Dynamic color palettes from wallpapers
      /rofi # App / Menu Launcher
      /thunar # File manager
      /waybar # Status bar
      /windsurf # Code editor
      /zsh # Terminal shell
    ]
    ++ lib.optionals (user.hostname == "notebook") [
      ../settings/hardware/power-management.nix # Control cpu performance with battery and charger
    ]
    ++ lib.optionals (user.hostname == "desktop") [
      ../settings/hardware/desktop.nix # WARNING: INITIALLY REPLACE CONTENT WITH /etc/nixos/hardware-configuration.nix

      ../settings/services/ydotool.nix # Tool to move cursor using the keyboard

      ../settings/security/protonvpn.nix # VPN GUI

      ../software/obs # Screen recorder
      ../software/syncthing # Synchronization tool
      ../software/xremap # Dynamic keybinds service
    ]
    ++ lib.optionals (user.hostname == "home-server") [
      # TODO: Make a Home Server
      #../settings/services/arr_suite.nix # Arr Suite
      #../settings/services/jellyfin.nix # Media server
    ];

  config = lib.optionalAttrs (user.hostname == "desktop") {
    user-manage.imports = [
      inputs.xremap-flake.homeManagerModules.default # Import xremap-flake home-manager modules
    ];
  };
}
