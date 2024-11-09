{
  inputs,
  pkgs,
  user,
  ...
}: {
  user.manage = {
    # -- Packages
    home.packages = [
      pkgs.unar # To extract files
      pkgs.obsidian # Knowledge database notes
      pkgs.telegram-desktop # groups
      pkgs.gimp
      inputs.nix-tagstudio.packages.${user.system}.tagstudio
    ];

    # -- Packages Icons
    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite = {
      "class<obsidian>" = "󰎚 "; # nf-md-note
      "class<org.telegram.desktop>" = " ";
      "class<zoom>" = " ";
    };
  };
}
