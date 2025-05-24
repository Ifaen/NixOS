{
  unstable-pkgs,
  pkgs,
  ...
}: {
  user-manage = {
    home.packages = [
      unstable-pkgs.protonvpn-gui

      # TODO: Still need to improve this
      # Script to check if VPN is connected before opening app (like qBitTorrent)
      "${pkgs.writeShellScriptBin "vpn-toggle-ports"
        ''
          if nmcli connection show --active | grep -qi protonvpn; then
            # If Port Forwarding is enabled
            if [ -s "/run/user/$UID/Proton/VPN/forwarded_port" ]; then
              PORT=$(cat "/run/user/$UID/Proton/VPN/forwarded_port") # Read the port of Port Forwarding

              # Open the port in iptables
              iptables -I INPUT -p tcp --dport "$PORT" -j ACCEPT
              iptables -I INPUT -p udp --dport "$PORT" -j ACCEPT
              ${pkgs.libnotify}/bin/notify-send "Port $PORT opened in iptables."
            fi
          else
            ${pkgs.libnotify}/bin/notify-send "ProtonVPN not connected."
          fi
        ''}"
    ];

    xdg.desktopEntries."protonvpn-app" = {
      name = "Proton VPN";
      exec = "protonvpn-app";
      icon = "proton-vpn-logo";
      categories = ["X-Rofi"];
    };

    hyprland.windowrulev2 = map (rule: rule + ", class:(.protonvpn-app-wrapped)") [
      "float" # Makes sure to float the window and subwindows
      "size <55% <55%"
    ];
  };
}
