{inputs, ...}: {
  imports =
    [
      ./hardware-configuration.nix # WARNING: INITIALLY REPLACE CONTENT WITH /etc/nixos/hardware-configuration.nix

      inputs.home-manager.nixosModules.home-manager # Imports home-manager as a nixos module
      inputs.nur.modules.nixos.default # Adds the NUR overlay
    ]
    ++ map (path: ../../modules + path) [
      /aliases/home-manager.nix # Aliases under home-manager
      /aliases/nixos.nix # Aliases under nixos

      /browsers/brave.nix # Brave browser
      /browsers/firefox # Firefox browser
      /browsers/google-chrome.nix # Google Chrome browser
      /browsers/mullvad.nix # Mullvad browser

      /hyprland # Window manager

      /utilities/drivers.nix # Few drivers, depending of the hardware

      /security/hyprlock.nix # System password lock
      /security/keepassxc.nix # Password manager
      /security/networking.nix # Networking
      /security/polkit.nix # Policy kit (to grant system privileges to user)
      /security/protonvpn.nix # VPN GUI
      /security/ssh.nix # SSH configuration
      # /security/sudo.nix # Sudo configuration

      #/services/kando # App / Menu Launcher FIXME: Make it declarative
      /services/hypridle.nix # Idle management daemon
      /services/mako # Notification daemon
      /services/pipewire.nix # Every sound related service
      /services/portal.nix # XDG desktop portal
      /services/sddm.nix # Autologin in TTY1
      /services/syncthing # Synchronization tool
      /services/udisks2.nix # Allows applications to query and manipulate storage devices
      #/services/wireguard.nix # VPN service
      /services/xremap # Dynamic keybinds service
      /services/ydotool.nix # Tool to move cursor using the keyboard

      /settings/directories.nix # XDG directories

      /terminal/kitty # Terminal emulator
      /terminal/lf # Terminal file manager
      /terminal/zsh # Terminal shell
      /terminal/direnv.nix # Tool to automatically enter a nix-shell
      /terminal/git.nix # Code version control
      /terminal/nh.nix # Nix Helper
      /terminal/starship.nix # Shell prompt

      /tools/olive-editor # Video editor
      /tools/dupeguru # Duplicate file finder
      /tools/obs # Screen recorder
      /tools/packages.nix # TODO: Separate into different files
      /tools/rofi # App / Menu Launcher
      /tools/thunar # File manager
      /tools/waybar # Status bar
      /tools/windsurf # Code editor

      /themes/pywal # Dynamic color palettes from wallpapers
      /themes/fonts.nix # Characters fonts
      /themes/waypaper.nix # Wallpaper manager
      /themes/gtk.nix # GTK Toolkit configuration
      /themes/hyprcursor.nix # Cursor
      /themes/qt.nix # QT Toolkit configuration

      /utilities/ripdrag # Drag and drop application
    ];

  user-manage.imports = [
    inputs.xremap-flake.homeManagerModules.default # Import xremap-flake home-manager modules
  ];
}
