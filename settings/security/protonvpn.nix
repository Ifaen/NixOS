{pkgs, ...}: {
  user-manage = {
    home.packages = [pkgs.protonvpn-gui];

    xdg.desktopEntries."protonvpn-app" = {
      name = "Proton VPN";
      exec = "protonvpn-app";
      categories = ["X-Rofi" "Network"];
      icon = "proton-vpn-logo";
      terminal = false;
    };

    hyprland.windowrulev2 = map (rule: rule + ", class:(.protonvpn-app-wrapped)") [
      "size <55% <55%"
    ];
  };
}
