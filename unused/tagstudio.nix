{
  inputs,
  user,
  ...
}: {
  user-manage = {
    home.packages = [inputs.nix-tagstudio.packages."x86_64-linux".tagstudio];

    xdg.desktopEntries.tagstudio = {
      name = "Tagstudio";
      exec = "tagstudio";
      icon = "tagstudio";
      categories = ["X-Rofi" "AudioVideo" "Qt"];
      terminal = false;
    };

    hyprland.windowrulev2 = [
      "float, class:(tagstudio), title:(.*)(Add)(.*)"
    ];

    waybar-workspace-icon = {
      "class<tagstudio>" = "󰓹 "; # nf-md-tag
      "title<.*Add .*>" = "";
    };
  };
}
