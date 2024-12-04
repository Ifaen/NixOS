{pkgs, ...}: {
  user.manage = {
    home.packages = [
      pkgs.obsidian # Knowledge database notes
    ];

    xdg.desktopEntries.obsidian = {
      name = "Obsidian";
      exec = "${pkgs.obsidian}/bin/obsidian %u";
      categories = ["X-Rofi" "Office"];
      mimeType = ["x-scheme-handler/obsidian"];
      icon = "obsidian";
      terminal = false;
    };

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite."class<obsidian>" = "󰎚 "; # nf-md-note
  };
}
