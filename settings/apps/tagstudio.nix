{
  inputs,
  user,
  ...
}: {
  user-manage = {
    home.packages = [inputs.nix-tagstudio.packages.${user.system}.tagstudio];

    xdg.desktopEntries.tagstudio = {
      name = "Tagstudio";
      exec = "${inputs.nix-tagstudio.packages.${user.system}.tagstudio}/bin/tagstudio";
      icon = "tagstudio";
      categories = ["X-Rofi" "AudioVideo" "Qt"];
      terminal = false;
    };

    hyprland.windowrulev2 = [
      "float, class:(tagstudio), title:^(.*Add.*)$"
      "rounding 10, class:(tagstudio), title:^(.*Add.*)$"
    ];

    waybar-workspace-icon = {
      "class<tagstudio>" = "󰓹 "; # nf-md-tag
      #"class<tagstudio> title<.*Add.*>" = "";
    };
  };
}
