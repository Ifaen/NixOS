{pkgs, ...}: {
  user-manage = {
    programs.obs-studio = {
      enable = true;

      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
    };

    xdg.desktopEntries."com.obsproject.Studio" = {
      name = "OBS Studio";
      exec = "obs --disable-shutdown-check %U";
      categories = ["X-Rofi"];
      icon = "com.obsproject.Studio";
      startupNotify = true;
    };
  };
}
