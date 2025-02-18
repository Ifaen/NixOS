{
  lib,
  pkgs,
  user,
  ...
}: {
  user-manage =
    {
      home.packages = [pkgs.obsidian]; # Knowledge database notes

      xdg.desktopEntries.obsidian = {
        name = "Obsidian";
        exec = "obsidian %u";
        categories = ["X-Rofi" "Office"];
        mimeType = ["x-scheme-handler/obsidian"];
        icon = "obsidian";
        terminal = false;
      };
    }
    // lib.optionalAttrs (user.machine != "wsl") {
      waybar-workspace-icon."class<obsidian>" = "󰎚 "; # nf-md-note
    };
}
