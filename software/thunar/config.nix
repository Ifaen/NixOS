{pkgs, ...}: {
  programs.thunar = {
    enable = true;

    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  services.tumbler.enable = true; # Thumbnail support for images

  user-manage = {
    hyprland.windowrulev2 = map (rule: rule + ", class:(thunar)") [
      "float"
      "size 80% 80%"
    ];

    waybar-workspace-icon."class<thunar>" = "";
  };
}
