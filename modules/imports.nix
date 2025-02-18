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

      ../settings/aliases/nixos.nix # Aliases under nixos

      ../settings/apps/obsidian.nix # Notes

      ../settings/security/polkit.nix # Policy kit (to grant system privileges to user)

      ../settings/shell/direnv.nix # Tool to automatically enter a nix-shell
      ../settings/shell/git.nix # Code version control
      ../settings/shell/nh.nix # Nix Helper

      ../settings/themes/fonts.nix
      ../settings/themes/hyprcursor.nix # Cursor
      ../settings/themes/gtk.nix # GTK Toolkit configuration
      ../settings/themes/qt.nix # QT Toolkit configuration

      # Web browser
      ../software/firefox/bookmarks.nix
      ../software/firefox/config.nix
      ../software/firefox/extensions.nix
      ../software/firefox/policies.nix
      ../software/firefox/settings.nix

      # Terminal file manager
      ../software/lf/config.nix
      ../software/lf/keybinds.nix
      ../software/lf/previewer.nix

      # App / Menu Launcher
      ../software/rofi/config.nix
      ../software/rofi/theme.nix

      # Code editor
      ../software/vscode/config.nix
      ../software/vscode/extensions.nix
      ../software/vscode/keybinds.nix
      ../software/vscode/settings.nix

      # Terminal emulator
      ../software/wezterm/config.nix
      ../software/wezterm/keybinds.nix

      ../software/xdg/config.nix
      ../software/xdg/directories.nix
      ../software/xdg/mimeapps.nix
      ../software/xdg/portal.nix

      # Terminal shell
      ../software/zsh/config.nix
      ../software/zsh/tools.nix
    ]
    ++ lib.optionals (user.machine != "wsl") [
      ../settings/aliases/home-manager.nix # Aliases under home-manager

      ../settings/apps/ripdrag.nix # Drag utility

      ../settings/hardware/drivers.nix # Few drivers depending of the hardware

      ../settings/shell/starship.nix # Shell prompt

      ../settings/security/getty.nix # Autologin
      ../settings/security/hyprlock.nix # System password lock
      ../settings/security/networking.nix # Networking
      ../settings/security/keepassxc.nix # Password manager

      ../settings/services/hypridle.nix # Idle management daemon
      ../settings/services/pipewire.nix # Every sound related service
      ../settings/services/udisks2.nix # Allows applications to query and manipulate storage devices

      ../settings/themes/pywal.nix

      ../settings/apps/pavucontrol.nix # Audio controller
      ../settings/apps/waypaper.nix # Wallpaper manager

      # Window manager
      ../software/hyprland/config.nix
      ../software/hyprland/keybinds.nix
      ../software/hyprland/style.nix

      # Notification daemon
      ../software/mako/config.nix

      # File manager
      ../software/thunar/config.nix
      ../software/thunar/preferences.nix

      # Status bar
      ../software/waybar/config.nix
      ../software/waybar/modules.nix

      # Logout interface
      ../software/wlogout/config.nix
    ]
    ++ lib.optionals (user.machine == "desktop") [
      ../settings/apps/gimp.nix # Image Editor
      ../settings/apps/discord.nix # Voice chat
      ../settings/apps/spotify.nix # Music provider
      ../settings/apps/scrcpy.nix # Mobile screen copy

      ../settings/hardware/desktop.nix # WARNING: INITIALLY REPLACE CONTENT WITH /etc/nixos/hardware-configuration.nix

      ../settings/services/ydotool.nix # Tool to move cursor using the keyboard

      ../settings/security/openvpn.nix # VPN

      # Screen recorder
      ../software/obs/config.nix
      ../software/obs/settings.nix

      # Synchronization tool
      ../software/syncthing/config.nix
      ../software/syncthing/sync.nix

      # Dynamic keybinds service
      ../software/xremap/config.nix
      ../software/xremap/keybinds.nix
    ]
    ++ lib.optionals (user.machine == "notebook") [
      ../settings/hardware/notebook.nix # WARNING: INITIALLY REPLACE CONTENT WITH /etc/nixos/hardware-configuration.nix
      ../settings/hardware/power-management.nix # Control cpu performance with battery and charger
    ]
    ++ lib.optionals (user.machine == "wsl") [
      inputs.nixos-wsl.nixosModules.default # wsl options
    ];

  config = lib.optionalAttrs (user.machine == "desktop") {
    user-manage.imports = [
      inputs.xremap-flake.homeManagerModules.default # Import xremap-flake home-manager modules
    ];
  };
}
