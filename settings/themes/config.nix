{...}: {
  # -- Make apps use Wayland over Xwayland → https://wiki.hyprland.org/Configuring/Environment-variables/
  user.manage.wayland.windowManager.hyprland.settings.env = [
    "GDK_BACKEND, wayland,x11,*" # GTK: Use wayland if available. If not: try x11, then any other GDK backend
    "QT_QPA_PLATFORM, wayland;xcb" # Qt: Use wayland if available, fall back to x11 if not

    "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1" # Disables window decorations on Qt applications
  ];
}
