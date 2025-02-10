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

      ../software/firefox/bookmarks.nix
      ../software/firefox/config.nix
      ../software/firefox/extensions.nix
      ../software/firefox/policies.nix
      ../software/firefox/settings.nix

      ../software/lf/config.nix # Terminal file manager
      ../software/lf/keybinds.nix
      ../software/lf/previewer.nix

      ../software/rofi/config.nix # App / Menu Launcher
      ../software/rofi/theme.nix

      ../software/vscode/config.nix
      ../software/vscode/extensions.nix
      ../software/vscode/keybinds.nix
      ../software/vscode/settings.nix

      ../software/wezterm/config.nix # Terminal emulator
      ../software/wezterm/keybinds.nix

      ../software/xdg/config.nix
      ../software/xdg/directories.nix
      ../software/xdg/mimeapps.nix

      ../software/zsh/config.nix # Terminal shell
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

      ../software/hyprland/config.nix # Window manager
      ../software/hyprland/keybinds.nix
      ../software/hyprland/style.nix

      ../software/mako/config.nix # Notification daemon

      ../software/thunar/config.nix # File manager
      ../software/thunar/preferences.nix

      ../software/waybar/config.nix # Status bar
      ../software/waybar/modules.nix

      ../software/wlogout/config.nix # Logout interface

      ../software/xdg/portal.nix
    ]
    ++ lib.optionals (user.machine == "desktop") [
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
    ]
    ++ lib.optionals (user.machine == "notebook") [
      ../settings/hardware/notebook.nix # WARNING: INITIALLY REPLACE CONTENT WITH /etc/nixos/hardware-configuration.nix
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
