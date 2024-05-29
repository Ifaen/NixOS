{user, ...}: {
  # Configure OS
  imports =
    [
      ./apps/discord.nix # Voice chat
      ./apps/librewolf.nix # Web browser
      ./apps/firefox.nix # Web browser of work
      ./apps/vscode.nix # Code editor
      ./apps/thunderbird.nix # Email manager

      ./desktop/eww.nix # Status bar
      ./desktop/hyprland.nix # Window manager
      ./desktop/sddm.nix # Display manager
      ./desktop/swaylock.nix # System password lock
      ./desktop/themes.nix # Icons, fons, GTK and QT Theming
      ./desktop/waybar.nix # Status bar
      ./desktop/wlogout.nix # Logout interface
      ./desktop/wofi.nix # Software selector

      ./others/drivers.nix # Few drivers depending of the hardware
      ./others/file-management.nix # xdg-open and mimeapps
      ./others/hardware.nix # DO NOT use if it's cloned in another system

      ./services/keyboard-mapping.nix
      ./services/networking.nix
      ./services/portal.nix
      ./services/secrets.nix
      ./services/sound.nix
      ./services/dunst.nix # Notification daemon
      ./services/swayidle.nix # Idle management daemon

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
