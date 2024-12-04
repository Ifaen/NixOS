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
      exec = "${pkgs.obs-studio}/bin/obs --disable-shutdown-check %U";
      categories = ["X-Rofi" "Recorder" "AudioVideo"];
      icon = "com.obsproject.Studio";
      startupNotify = true;
      terminal = false;
    };

    waybar-workspace-icon."class<com.obsproject.Studio>" = "󰄀 "; # nf-md-camera
  };
}
