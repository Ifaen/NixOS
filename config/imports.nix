{
  config,
  lib,
  options,
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
      /hypr/hyprland.keybinds.nix # Window manager keybindings
      /hypr/hyprlock.nix # System password lock

      /lf/config.nix # Terminal file browser configuration
      /lf/keybinds.nix # Terminal file browser keybinds
      /lf/previewer.nix # Terminal file browser previewer

      /obs/config.nix # Screen recorder
      /obs/settings.nix # Profile settings

      /rofi/config.nix # App / Menu Launcher

      /spotify/config.nix # Music provider

      /vivaldi/config.nix # Web Browser

      /vscode/config.nix
      /vscode/extensions.nix
      /vscode/keybinds.nix
      /vscode/settings.nix

      /waybar/config.nix # Status bar
      /waybar/modules-center.nix # Modules Center settings
      /waybar/modules-left.nix # Modules Left settings
      /waybar/modules-right.nix # Modules Right settings

      /waypaper/config.nix # Wallpaper manager

      /wlogout/config.nix # Logout interface

      /xdg/config.nix
      /xdg/directories.nix
      /xdg/mimeapps.nix
      /xdg/portal.nix

      /xremap/config.nix # Dynamic keybinds service
      /xremap/keybinds.nix # Dynamic keybinds service keybindings

      /zsh/config.nix # Terminal shell configuration
      /zsh/tools.nix # Terminal shell tools
    ]
    ++ [inputs.home-manager.nixosModules.home-manager]; # Imports home-manager and enables to use it alongside nixos configuration

  # -- After importing home-manager modules, made an alias for home-manager.users.${user.name} and reduce verbosity
  options = {
    user.manage = lib.mkOption {
      type = options.home-manager.users.type.functor.wrapped;
      default = {};
      description = "Home-manager configuration to be used for the user";
    };
  };

  config = {
    home-manager.users.${user.name} = lib.mkAliasDefinitions options.user.manage; # Make user.manage to be an alias of home-manager.users.${user.name}

    user.manage.imports = [inputs.xremap-flake.homeManagerModules.default]; # Import xremap-flake home-manager modules
  };
}
