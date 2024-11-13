{
  inputs,
  user,
  ...
}: {
  imports =
    map (path: ../settings + path) [
      /hardware/config.nix # INITIALLY REPLACE CONTENT WITH /etc/nixos/hardware-configuration.nix
      /hardware/drivers.nix # Few drivers depending of the hardware

      /secrets/keepassxc.nix
      /secrets/networking.nix
      /secrets/polkit.nix

      /services/openvpn.nix
      /services/sound.nix # Every sound related service
      /services/sync.nix # Tools to synchronize between systems
      /services/ydotool.nix # Tool to move cursor using the keyboard

      /shell/git.nix # Code version control
      /shell/starship.nix # Shell prompt

      /themes/config.nix
      /themes/fonts.nix
    ]
    ++ map (path: ../software + path) [
      /discord/config.nix # Voice chat

      /dunst/config.nix # Notification daemon

      /foot/config.nix # Terminal emulator
      /foot/keybinds.nix
      /foot/settings.nix

      /hypr/hyprcursor.nix # Cursor
      /hypr/hypridle.nix # Idle management daemon
      /hypr/hyprland.config.nix # Window manager
      /hypr/hyprland.keybinds.nix
      /hypr/hyprlock.nix # System password lock

      /lf/config.nix # Terminal file browser configuration
      /lf/keybinds.nix
      /lf/previewer.nix

      /obs/config.nix # Screen recorder
      /obs/settings.nix

      /rofi/theme.nix

      /rofi/config.nix # App / Menu Launcher

      /vivaldi/config.nix # Web Browser

      /vscode/config.nix
      /vscode/extensions.nix
      /vscode/keybinds.nix
      /vscode/settings.nix

      /spotify/config.nix # Music provider
      /waybar/config.nix # Status bar
      /waybar/modules-center.nix
      /waybar/modules-left.nix
      /waybar/modules-right.nix

      /waypaper/config.nix # Wallpaper manager

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
