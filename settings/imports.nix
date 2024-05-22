{
  config,
  user,
  ...
}: {
  # Configure OS
  imports =
    [
      ./desktop/hyprland.nix # Window manager
      ./desktop/sddm.nix # Display manager
      ./desktop/swaylock.nix # System password lock
      ./desktop/themes.nix # Icons, fons, GTK and QT Theming

      ./services/file-management.nix
      ./services/keyboard-mapping.nix
      ./services/networking.nix
      ./services/portal.nix
      ./services/secrets.nix
      ./services/sound.nix

      ./others/drivers.nix
      ./others/hardware.nix
      ./others/language.nix

      ./commandline/shell.nix # Terminal shell configuration
    ]
    ++ (
      if user.machine == "desktop"
      then [
        ./others/virtualisation.nix
      ]
      else []
    );

  # Configure HM
  home-manager.users."${user.name}".imports =
    [
      ./apps/discord.nix # Voice chat
      ./apps/librewolf.nix # Web browser
      ./apps/firefox.nix # Web browser of work
      ./apps/vscode.nix # Code editor
      ./apps/thunderbird.nix # Email manager

      ./desktop/waybar.nix # Status bar
      ./desktop/wlogout.nix # Logout interface
      ./desktop/wofi.nix # Software selector

      ./services/dunst.nix # Notification daemon
      ./services/swayidle.nix # Idle management daemon

      ./commandline/git.nix # Code version control
      ./commandline/lf.nix # Terminal file browser
      ./commandline/starship.nix # Shell prompt customization
      ./commandline/terminal.nix # Terminal simulator
    ]
    ++ (
      if user.machine == "desktop"
      then [
        ./apps/obs.nix # Screen recorder
      ]
      else []
    );
}
