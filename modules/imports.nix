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
    ]
    ++ map (path: ../settings + path) [
      /aliases/home-manager.nix # Aliases under home-manager
      /aliases/nixos.nix # Aliases under nixos

      /hardware/drivers.nix # Few drivers, depending of the hardware

      /security/hyprlock.nix # System password lock
      /security/keepassxc.nix # Password manager
      /security/networking.nix # Networking
      /security/polkit.nix # Policy kit (to grant system privileges to user)

      /services/getty.nix # Autologin in TTY1
      /services/hypridle.nix # Idle management daemon
      /services/pipewire.nix # Every sound related service
      /services/udisks2.nix # Allows applications to query and manipulate storage devices

      /shell/direnv.nix # Tool to automatically enter a nix-shell
      /shell/git.nix # Code version control
      /shell/nh.nix # Nix Helper
      /shell/starship.nix # Shell prompt

      /themes/fonts.nix # Characters fonts
      /themes/gtk.nix # GTK Toolkit configuration
      /themes/hyprcursor.nix # Cursor
      /themes/qt.nix # QT Toolkit configuration
      /themes/waypaper.nix # Wallpaper manager
    ]
    ++ map (path: ../software + path) [
      # Web Browser
      /firefox/bookmarks.nix
      /firefox/config.nix
      /firefox/extensions.nix
      /firefox/policies.nix
      /firefox/settings.nix
      /firefox/style.nix

      # Window manager
      /hyprland/config.nix
      /hyprland/keybinds.nix
      /hyprland/style.nix

      # Status bar
      /hyprpanel/config.nix
      /hyprpanel/settings.nix

      /kando/config.nix # App / Menu Launcher

      # Terminal emulator
      /kitty/config.nix
      /kitty/keybinds.nix

      # Terminal file manager
      /lf/config.nix
      /lf/keybinds.nix
      /lf/previewer.nix
      /lf/unbinds.nix

      /pywal/config.nix # Dynamic color palettes from wallpapers

      /rofi/config.nix # App / Menu Launcher

      # File manager
      /thunar/config.nix
      /thunar/preferences.nix

      # Code editor
      /vscode/config.nix
      /vscode/extensions.nix
      /vscode/keybinds.nix
      /vscode/settings.nix
      /vscode/snippets.nix

      # XDG configuration
      /xdg/config.nix
      /xdg/directories.nix
      /xdg/mimeapps.nix
      /xdg/portal.nix

      # Terminal shell
      /zsh/config.nix
      /zsh/tools.nix
    ]
    ++ lib.optionals (user.machine == "notebook") [
      ../settings/hardware/notebook.nix # WARNING: INITIALLY REPLACE CONTENT WITH /etc/nixos/hardware-configuration.nix
      ../settings/hardware/power-management.nix # Control cpu performance with battery and charger
    ]
    ++ lib.optionals (user.machine == "desktop") [
      ../settings/hardware/desktop.nix # WARNING: INITIALLY REPLACE CONTENT WITH /etc/nixos/hardware-configuration.nix

      ../settings/services/ollama.nix # Ollama
      ../settings/services/ydotool.nix # Tool to move cursor using the keyboard

      ../settings/security/protonvpn.nix # VPN GUI

      # Screen recorder
      ../software/obs/config.nix
      ../software/obs/settings.nix

      # Synchronization tool
      ../software/syncthing/config.nix
      ../software/syncthing/sync.nix

      # Dynamic keybinds service
      ../software/xremap/config.nix
      ../software/xremap/keybinds.nix
    ]
    ++ lib.optionals (user.machine == "home-server") [
      # TODO: Make a Home Server
      #../settings/services/arr_suite.nix # Arr Suite
      #../settings/services/jellyfin.nix # Media server
    ];

  config = lib.optionalAttrs (user.machine == "desktop") {
    user-manage.imports = [
      inputs.xremap-flake.homeManagerModules.default # Import xremap-flake home-manager modules
      inputs.hyprpanel.homeManagerModules.hyprpanel # Import hyprpanel home-manager modules
    ];
  };
}
