{...}: {
  user-manage = {
    programs.kitty.keybindings = {
      "ctrl+c" = "copy_to_clipboard";
      "ctrl+v" = "paste_from_clipboard";
      "esc" = ''send_text all \x03'';

      # Unbinds
      "ctrl+shift+c" = "none";
      "ctrl+shift+v" = "none";
    };
  };
}
