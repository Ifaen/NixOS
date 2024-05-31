{user, ...}: {
  # Configure OS
  imports =
    [
      # TODO Changing folders to be per app instead of category
      ./hypr/hypridle.nix # Idle management daemon
      ./hypr/hyprland.nix # Window manager
      ./hypr/hyprlock.nix # System password lock

      ./waybar/waybar.general.nix
      ./waybar/waybar.settings.nix

      ./apps/discord.nix # Voice chat
      ./apps/librewolf.nix # Web browser
      ./apps/firefox.nix # Web browser of work
      ./apps/vscode.nix # Code editor
      ./apps/thunderbird.nix # Email manager

      ./desktop/eww.nix # Status bar
      ./desktop/sddm.nix # Display manager
      ./desktop/themes.nix # Icons, fons, GTK and QT Theming
      ./desktop/waybar.nix # Status bar
      ./desktop/wlogout.nix # Logout interface
      ./desktop/wofi.nix # Software selector

      ./others/drivers.nix # Few drivers depending of the hardware
      ./others/file-management.nix # xdg-open and mimeapps
      ./others/hardware.nix # DO NOT use if it's cloned in another system

      ./services/keybindings.nix
      ./services/networking.nix
      ./services/portal.nix
      ./services/secrets.nix
      ./services/sound.nix
      ./services/dunst.nix # Notification daemon

      ./shell/git.nix # Code version control
      ./shell/lf.nix # Terminal file browser
      ./shell/starship.nix # Shell prompt customization
      ./shell/wezterm.nix # Terminal simulator
      ./shell/zsh.nix # Terminal shell configuration
    ]
    ++ (
      if user.machine == "desktop"
      then [
        ./apps/obs.nix # Screen recorder
      ]
      else []
    );
}
