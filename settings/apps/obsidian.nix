{pkgs, ...}: {
  user-manage = {
    home.packages = [pkgs.obsidian]; # Knowledge database notes

    xdg.desktopEntries.obsidian = {
      name = "Obsidian";
      exec = "obsidian %u";
      categories = ["X-Rofi" "Office"];
      mimeType = ["x-scheme-handler/obsidian"];
      icon = "obsidian";
      terminal = false;
    };

    waybar-workspace-icon."class<obsidian>" = "󰎚 "; # nf-md-note
  };
}
