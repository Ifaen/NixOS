{
  pkgs,
  user,
  ...
}: {
  ## SYSTEM PACKAGES
  environment.systemPackages = with pkgs; [
    unar # To extract files
    zapzap # Whatsapp web
    telegram-desktop # groups
    obsidian # Knowledge database notes
  ];

  ## USER PACKAGES
  home-manager.users.${user.name}.programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite = {
    "class<obsidian>" = "󰎚 "; # nf-md-note
    "class<com.rtosta.zapzap>" = "󰖣 ";
    "class<gns3>" = "󱂇 ";
    "class<org.telegram.desktop>" = " ";
    "class<zoom>" = " ";
  };
}
