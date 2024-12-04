{user, ...}: {
  user-manage = {
    programs.thunderbird = {
      enable = true;

      profiles.${user.name} = {
        isDefault = true;
      };
    };

    #hyprland.exec-once = ["[workspace 14 silent] thunderbird"];

    waybar-workspace-icon."class<thunderbird>" = "󱗆 "; # nf-md-bird
  };
}
