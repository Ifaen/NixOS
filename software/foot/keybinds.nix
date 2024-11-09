{user, ...}: {
  user.manage = {
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
