{...}: {
  user-manage = {
    options,
    config,
    lib,
    ...
  }: {
    options = {
      hyprland = lib.mkOption {
        type = lib.types.attrsOf lib.types.anything;
        description = "Hyprland settings";
      };

      waybar-workspace-icon = lib.mkOption {
        type = lib.types.attrsOf lib.types.anything;
        description = "Waybar settings";
      };
    };

    config = {
      wayland.windowManager.hyprland.settings = lib.mkAliasDefinitions options.hyprland;

      programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite = lib.mkAliasDefinitions options.waybar-workspace-icon;
    };
  };
}
