{user, ...}: {
  imports = [
    ./davinci-resolve/davinci-resolve.config.nix # Video Editing
    ./davinci-resolve/davinci-resolve.datafiles.nix # Video Editing data files

    ./discord/discord.config.nix # Voice chat

    ./dunst/dunst.config.nix # Notification daemon

    ./foot/foot.config.nix # Terminal emulator
    ./foot/foot.settings.nix

    #./games/minecraft/minecraft.config.nix

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

    ./obs/obs.config.nix # Screen recorder
    ./obs/obs.settings.nix # Profile settings

    ./sddm/sddm.config.nix # Display manager

    ./secrets/secrets.keepassxc.nix
    ./secrets/secrets.networking.nix
    ./secrets/secrets.polkit.nix

    ./services/services.openvpn.nix
    ./services/services.sound.nix
    ./services/services.sync.nix # Tools to synchronize between systems

    ./starship/starship.config.nix # Shell prompt customization

    ./themes/themes.config.nix
    ./themes/themes.fonts.nix

    #./thunderbird/thunderbird.config.nix # Email manager

    ./vivaldi/vivaldi.config.nix # Web Browser

    ./vscode/vscode.config.nix
    ./vscode/vscode.extensions.nix
    ./vscode/vscode.keybinds.nix
    ./vscode/vscode.settings.nix

    ./waybar/waybar.config.nix # Status bar
    ./waybar/waybar.modules-center.nix # Modules Center settings
    ./waybar/waybar.modules-left.nix # Modules Left settings
    ./waybar/waybar.modules-right.nix # Modules Right settings

    ./waypaper/waypaper.nix # Wallpaper manager

    #./wezterm/wezterm.config.nix
    #./wezterm/wezterm.keybinds.nix

    ./wlogout/wlogout.config.nix # Logout interface

    ./wofi/wofi.config.nix # Software selector

    ./xdg/xdg.config.nix
    ./xdg/xdg.directories.nix
    ./xdg/xdg.mimeapps.nix
    ./xdg/xdg.portal.nix

    ./xremap/xremap.config.nix # Dynamic keybinds service
    ./xremap/xremap.keybinds.nix # Dynamic keybinds service keybindings

    ./zsh/zsh.config.nix # Terminal shell configuration
    ./zsh/zsh.tools.nix # Terminal shell tools..
  ];
}
