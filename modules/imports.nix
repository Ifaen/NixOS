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
    ]
    ++ map (path: ../settings + path) [
      /aliases/home-manager.nix # Aliases under home-manager
      /aliases/nixos.nix # Aliases under nixos

      /apps/obsidian.nix # Notes
      /apps/pavucontrol.nix # Audio controller
      /apps/ripdrag.nix # Drag utility
      /apps/waypaper.nix # Wallpaper manager

      /hardware/drivers.nix # Few drivers depending of the hardware

      /security/getty.nix # Autologin
      /security/hyprlock.nix # System password lock
      /security/keepassxc.nix # Password manager
      /security/networking.nix # Networking
      /security/polkit.nix # Policy kit (to grant system privileges to user)

      /services/hypridle.nix # Idle management daemon
      /services/pipewire.nix # Every sound related service
      /services/udisks2.nix # Allows applications to query and manipulate storage devices

      /shell/direnv.nix # Tool to automatically enter a nix-shell
      /shell/git.nix # Code version control
      /shell/nh.nix # Nix Helper
      /shell/starship.nix # Shell prompt

      /themes/fonts.nix
      /themes/gtk.nix # GTK Toolkit configuration
      /themes/hyprcursor.nix # Cursor
      /themes/pywal.nix
      /themes/qt.nix # QT Toolkit configuration
    ]
    ++ map (path: ../software + path) [
      /firefox/config.nix
      /firefox/policies.nix

      /hyprland/config.nix # Window manager
      /hyprland/keybinds.nix
      /hyprland/style.nix

      /lf/config.nix # Terminal file manager
      /lf/keybinds.nix
      /lf/previewer.nix

      /mako/config.nix # Notification daemon

      /rofi/config.nix # App / Menu Launcher
      /rofi/theme.nix

      /thunar/config.nix # File manager
      /thunar/preferences.nix

      /vivaldi/config.nix # Web Browser

      /vscode/config.nix
      /vscode/extensions.nix
      /vscode/keybinds.nix
      /vscode/settings.nix

      /waybar/config.nix # Status bar
      /waybar/modules.nix

      /wezterm/config.nix # Terminal emulator
      /wezterm/keybinds.nix

      /wlogout/config.nix # Logout interface

      /xdg/config.nix
      /xdg/directories.nix
      /xdg/mimeapps.nix
      /xdg/portal.nix

      /zsh/config.nix # Terminal shell
      /zsh/tools.nix
    ]
    ++ lib.optional (user.machine == "notebook") ../settings/hardware/notebook.nix # WARNING: INITIALLY REPLACE CONTENT WITH /etc/nixos/hardware-configuration.nix
    ++ lib.optional (user.machine == "desktop") [
      ../settings/apps/gimp.nix # Image Editor
      ../settings/apps/discord.nix # Voice chat
      ../settings/apps/spotify.nix # Music provider
      ../settings/apps/scrcpy.nix # Mobile screen copy

      ../settings/hardware/desktop.nix # WARNING: INITIALLY REPLACE CONTENT WITH /etc/nixos/hardware-configuration.nix

      ../settings/services/ydotool.nix # Tool to move cursor using the keyboard

      ../settings/security/openvpn.nix # VPN

      ../software/obs/config.nix # Screen recorder
      ../software/obs/settings.nix

      ../software/syncthing/config.nix # Synchronization tool
      ../software/syncthing/sync.nix

      ../software/xremap/config.nix # Dynamic keybinds service
      ../software/xremap/keybinds.nix
    ];

  config = lib.optionalAttrs (user.machine == "desktop") {
    user-manage.imports = [
      inputs.xremap-flake.homeManagerModules.default # Import xremap-flake home-manager modules
    ];
  };
}
