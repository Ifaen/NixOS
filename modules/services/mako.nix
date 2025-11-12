{...}: {
  user-manage.services.mako = {
    enable = true;

    settings = {
      output = ""; # When empty, notification is shown in the active screen
      sort = "-time";
      layer = "overlay";
      background-color = "#1e222a7f";
      width = 450;
      height = 150;
      border-size = 0;
      border-color = "#14181d";
      border-radius = 10;
      icons = true; # = 0;
      max-icon-size = 64;
      default-timeout = 5000;
      ignore-timeout = 0;
      font = "monospace 10";
      margin = 12;
      padding = "12, 20";

      markup = true;

      actions = true;
      anchor = "top-right";
      "actionable=true" = {
        anchor = "top-left";
      };

      "urgency=low" = {
        border-color = "#cccccc";
      };
      "urgency=normal" = {
        border-color = "#99c0d0";
      };
      "urgency=critical" = {
        border-color = "#bf616a";
        default-timeout = 0;
      };
    };
  };
}
