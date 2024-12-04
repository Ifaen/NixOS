{...}: {
  user-manage = {
    programs.foot.settings = {
      key-bindings = {
        #clipboard-copy = "Control+c XF86Copy"; # Default: Control+Shift+c XF86Copy
        #clipboard-paste = "Control+v XF86Paste"; # Default: Control+Shift+v XF86Paste
      };
      text-bindings = {
        #"\\x03" = "Escape";
      };
    };

    services.xremap.config.keymap = [
      {
        name = "workspace";

        remap = {
          super-space.launch = ["hyprctl" "dispatch" "workspace" "11"];
          super-shift-space.launch = ["hyprctl" "dispatch" "movetoworkspace" "11"];
        };
      }
    ];
  };
}
