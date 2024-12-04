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
    hyprland.windowrulev2 = [
      "float, class:(thunar)"
      "size 80% 80%, class:(thunar)"
    ];

    waybar-workspace-icon."class<thunar>" = "";
  };
}
