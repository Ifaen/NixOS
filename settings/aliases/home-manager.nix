{...}: {
  user-manage = {
    options,
    config,
    lib,
    ...
  }: {
    options = {
      hyprland = lib.mkOption {
        type = options.wayland.windowManager.hyprland.settings.type.functor.wrapped;
        default = {};
        description = "Hyprland settings";
      };

      waybar-workspace-icon = lib.mkOption {
        type = lib.types.anything;
        default = {};
        description = "Hyprland settings";
      };
    };

    config = {
      wayland.windowManager.hyprland.settings = lib.mkAliasDefinitions options.hyprland;

      programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite = lib.mkAliasDefinitions options.waybar-workspace-icon;
    };
  };
}
