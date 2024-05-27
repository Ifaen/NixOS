{
  pkgs,
  user,
  ...
}: {
  ## SYSTEM PACKAGES
  environment.systemPackages =
    (with pkgs; [
      unar # To extract files
      zapzap # Whatsapp web
      telegram-desktop # groups
      obsidian # Knowledge database notes
      # INFRAESTRUCTURA TI
      zoom-us
      inetutils # Collection of common network programs like telnet
      dynamips # Emulator computer program that was written to emulate Cisco routers
      gns3-gui # Graphical user interface for controlling the GNS3
      ubridge # Bridge for UDP tunnels, Ethernet, TAP, and VMnet interfaces
    ])
    ++ (with pkgs.stable; [
      gns3-server # Graphical Network Simulator 3 server
    ])
    # Packages specific to device
    ++ (
      if (user.machine == "notebook")
      then
        with pkgs; [
          tigervnc
        ]
      else []
    );

  ## USER PACKAGES
  home-manager.users."${user.name}" = {
    home.packages = [];

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite = {
      "class<com.rtosta.zapzap>" = "󰖣";
      "class<gns3>" = "󱂇";
      "class<org.telegram.desktop>" = "";
      "class<zoom>" = "";
    };
  };
}
