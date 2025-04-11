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
    };

    config = {
      wayland.windowManager.hyprland.settings = lib.mkAliasDefinitions options.hyprland;
    };
  };
}
