{
  pkgs,
  ...
}: {
  user-manage.home.pointerCursor = {
    enable = true;

    package = pkgs.borealis-cursors;

    name = "Borealis-cursors";

    hyprcursor.enable = true; # Whether to enable hyprcursor config generation. Supported by Qt, Chromium, Electron and Hypr Ecosystem

    gtk.enable = true; # Whether to enable gtk config generation for home.pointerCursor. Gtk does not support hyprcursor currently.
  };
}
