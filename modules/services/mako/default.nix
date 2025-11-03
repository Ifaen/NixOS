{...}: {
  user-manage.services.mako = {
    enable = true;

    settings = {
      "actionable=true" = {
        anchor = "top-left";
      };
      actions = true;
      anchor = "top-right";
      background-color = "#000000";
      border-color = "#FFFFFF";
      border-radius = 0;
      default-timeout = 5000;
      ignore-timeout = false;
      font = "monospace 10";
      height = 100;
      icons = true;
      layer = "top";
      margin = 10;
      markup = true;
      width = 300;
      output = ""; # When empty, notification is shown in the active screen
    };
  };
}
