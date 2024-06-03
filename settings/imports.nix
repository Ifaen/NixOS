{user, ...}: {
  imports =
    [
      ./discord/discord.config.nix # Voice chat
      ./dunst/dunst.dunst.nix # Notification daemon
      ./eww/eww.config.nix # Status bar
      ./firefox/firefox.config.nix # Web browser
      ./firefox/firefox.profile.aventuraspatagonia.nix
      ./firefox/firefox.profile.default.nix
      ./git/git.config.nix # Code version control
      ./hardware/hardware.config.nix # INITIALLY REPLACE CONTENT WITH /etc/nixos/hardware-configuration.nix
      ./hardware/hardware.drivers.nix # Few drivers depending of the hardware
      ./hypr/hypridle.nix # Idle management daemon
      ./hypr/hyprland.config.nix # Window manager
      ./hypr/hyprland.keybinds.nix # Window manager keybindings
      ./hypr/hyprlock.nix # System password lock
      ./lf/lf.config.nix # Terminal file browser configuration
      ./lf/lf.keybinds.nix # Terminal file browser keybinds
      ./lf/lf.previewer.nix # Terminal file browser previewer
      ./sddm/sddm.config.nix # Display manager
      ./secrets/secrets.keepassxc.nix
      ./secrets/secrets.networking.nix
      ./secrets/secrets.polkit.nix
      ./services/services.sound.nix
      ./starship/starship.config.nix # Shell prompt customization
      ./themes/themes.config.nix
      ./themes/themes.fonts.nix
      ./thunderbird/thunderbird.config.nix # Email manager
      ./vscode/vscode.config.nix
      ./vscode/vscode.keybinds.nix
      ./vscode/vscode.settings.nix
      ./waybar/waybar.general.nix # Status bar
      ./waybar/waybar.settings.nix # Status bar settings
      ./wezterm/wezterm.config.nix # Terminal simulator
      ./wezterm/wezterm.keybinds.nix # Terminal simulator keybindings
      ./wlogout/wlogout.config.nix # Logout interface
      ./wofi/wofi.config.nix # Software selector
      ./xdg/xdg.config.nix
      ./xdg/xdg.directories.nix
      ./xdg/xdg.mimemapps.nix
      ./xdg/xdg.portal.nix
      ./xremap/xremap.config.nix # Dynamic keybinds service
      ./xremap/xremap.keybinds.nix # Dynamic keybinds service keybindings
      ./zsh/zsh.config.nix # Terminal shell configuration
      ./zsh/zsh.tools.nix # Terminal shell tools..
    ]
    ++ (
      if user.machine == "desktop"
      then [
        ./obs/obs.config.nix # Screen recorder
      ]
      else []
    );
}
