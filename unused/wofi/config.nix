{...}: {
  user-manage = {
    programs.wofi = {
      enable = true;
    };

    waybar-workspace-icon."class<wofi>" = "󰼢 ";
  };
}
