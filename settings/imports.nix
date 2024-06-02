{user, ...}: {
  # Configure OS
  imports =
    [
      # TODO Changing folders to be per app instead of category
      ./firefox/firefox.config.nix # Web browser
      ./firefox/firefox.profile.aventuraspatagonia.nix
      ./firefox/firefox.profile.default.nix

      ./hardware/hardware.config.nix # INITIALLY REPLACE CONTENT WITH /etc/nixos/hardware-configuration.nix
      ./hardware/hardware.drivers.nix # Few drivers depending of the hardware

      ./hypr/hypridle.nix # Idle management daemon
      ./hypr/hyprland.config.nix # Window manager
      ./hypr/hyprland.keybinds.nix # Window manager keybindings
      ./hypr/hyprlock.nix # System password lock

      ./lf/lf.config.nix # Terminal file browser configuration
      ./lf/lf.keybinds.nix # Terminal file browser keybinds
      ./lf/lf.previewer.nix # Terminal file browser previewer

      ./waybar/waybar.general.nix # Status bar
      ./waybar/waybar.settings.nix # Status bar settings

      ./xdg/xdg.config.nix
      ./xdg/xdg.directories.nix
      ./xdg/xdg.mimemapps.nix
      ./xdg/xdg.portal.nix

      ./wezterm/wezterm.config.nix # Terminal simulator
      ./wezterm/wezterm.keybinds.nix # Terminal simulator keybindings

      ./xremap/xremap.config.nix # Dynamic keybinds service
      ./xremap/xremap.keybinds.nix # Dynamic keybinds service keybindings

      ./zsh/zsh.config.nix # Terminal shell configuration
      ./zsh/zsh.tools.nix # Terminal shell tools

      # TODO Replace this paths
      ./apps/discord.nix # Voice chat
      ./apps/vscode.nix # Code editor
      ./apps/thunderbird.nix # Email manager

      ./desktop/eww.nix # Status bar
      ./desktop/sddm.nix # Display manager
      ./desktop/themes.nix # Icons, fons, GTK and QT Theming
      ./desktop/wlogout.nix # Logout interface
      ./desktop/wofi.nix # Software selector

      ./services/networking.nix
      ./services/secrets.nix
      ./services/sound.nix
      ./services/dunst.nix # Notification daemon

      ./shell/git.nix # Code version control

      ./shell/starship.nix # Shell prompt customization
    ]
    ++ (
      if user.machine == "desktop"
      then [
        ./apps/obs.nix # Screen recorder
      ]
      else []
    );
}
