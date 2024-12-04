{pkgs, ...}: {
  programs.thunar = {
    enable = true;

    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  services.tumbler.enable = true; # Thumbnail support for images

  user.manage = {
    wayland.windowManager.hyprland.settings.windowrulev2 = [
      "float, class:(thunar)"
      "size 80% 80%, class:(thunar)"
    ];

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite = {
      "class<thunar>" = "";
    };
  };
}
