{user, ...}: {
  user.manage.wayland.windowManager.hyprland.settings = {
    bindm = [
      "SUPER, mouse:272, movewindow" # SUPER + LMB
      "SUPER, mouse:273, resizewindow" # SUPER + RMB
    ];

    input = {
      kb_layout = user.language; # Keyboard layout to be directed to user language
      kb_options = "compose:caps"; # Remap Caps-Lock key to be Compose Key
    };
  };
}
