{user, ...}: {
  # Configure OS
  imports =
    [
      ./apps/discord.nix # Voice chat
      ./apps/librewolf.nix # Web browser
      ./apps/firefox.nix # Web browser of work
      ./apps/vscode.nix # Code editor
      ./apps/thunderbird.nix # Email manager

      ./commandline/shell.nix # Terminal shell configuration
      ./commandline/git.nix # Code version control
      ./commandline/lf.nix # Terminal file browser
      ./commandline/starship.nix # Shell prompt customization
      ./commandline/terminal.nix # Terminal simulator

      ./desktop/eww.nix # Status bar
      ./desktop/hyprland.nix # Window manager
      ./desktop/sddm.nix # Display manager
      ./desktop/swaylock.nix # System password lock
      ./desktop/themes.nix # Icons, fons, GTK and QT Theming
      ./desktop/waybar.nix # Status bar
      ./desktop/wlogout.nix # Logout interface
      ./desktop/wofi.nix # Software selector

      ./services/file-management.nix
      ./services/keyboard-mapping.nix
      ./services/networking.nix
      ./services/portal.nix
      ./services/secrets.nix
      ./services/sound.nix
      ./services/dunst.nix # Notification daemon
      ./services/swayidle.nix # Idle management daemon

      ./others/drivers.nix
      ./others/hardware.nix
    ]
    ++ (
      if user.machine == "desktop"
      then [
        ./apps/obs.nix # Screen recorder
      ]
      else []
    );
}
