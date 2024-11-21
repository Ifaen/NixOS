{inputs, ...}: {
  imports =
    map (path: ../settings + path) [
      /apps/discord.nix # Voice chat
      /apps/spotify.nix # Music provider

      /hardware/config.nix # WARNING: INITIALLY REPLACE CONTENT WITH /etc/nixos/hardware-configuration.nix
      /hardware/drivers.nix # Few drivers depending of the hardware

      /security/hyprlock.nix # System password lock
      /security/keepassxc.nix # Password manager
      /security/networking.nix # Networking
      /security/openvpn.nix # VPN
      /security/polkit.nix # Policy kit (to grant system privileges to user)

      /services/hypridle.nix # Idle management daemon
      /services/getty.nix # Autologin
      /services/pipewire.nix # Every sound related service
      /services/ydotool.nix # Tool to move cursor using the keyboard

      /shell/direnv.nix # Tool to automatically enter a nix-shell
      /shell/git.nix # Code version control
      /shell/nh.nix # Nix Helper
      /shell/starship.nix # Shell prompt

      /themes/fonts.nix
      /themes/gtk.nix
      /themes/hyprcursor.nix # Cursor
      /themes/pywal.nix
      /themes/qt.nix
    ]
    ++ map (path: ../software + path) [
      /hyprland/config.nix # Window manager
      /hyprland/keybinds.nix

      /lf/config.nix # Terminal file browser configuration
      /lf/keybinds.nix
      /lf/previewer.nix

      /mako/config.nix # Notification daemon

      /obs/config.nix # Screen recorder
      /obs/settings.nix

      /syncthing/config.nix # Tools to synchronize between systems
      /syncthing/sync.nix # Tools to synchronize between systems

      /rofi/config.nix # App / Menu Launcher
      /rofi/theme.nix

      /vivaldi/config.nix # Web Browser

      /vscode/config.nix
      /vscode/extensions.nix
      /vscode/keybinds.nix
      /vscode/settings.nix

      /waybar/config.nix # Status bar
      /waybar/modules-center.nix
      /waybar/modules-left.nix
      /waybar/modules-right.nix

      /waypaper/config.nix # Wallpaper manager

      /wezterm/config.nix # Terminal emulator
      /wezterm/keybinds.nix

      /wlogout/config.nix # Logout interface

      /xdg/config.nix
      /xdg/directories.nix
      /xdg/mimeapps.nix
      /xdg/portal.nix

      /xremap/config.nix # Dynamic keybinds service
      /xremap/keybinds.nix

      /zsh/config.nix # Terminal shell
      /zsh/tools.nix
    ]
    ++ [inputs.home-manager.nixosModules.home-manager]; # Imports home-manager as a nixos module

  user.manage.imports = [
    inputs.xremap-flake.homeManagerModules.default # Import xremap-flake home-manager modules
  ];
}
