{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.pw-volume # Basic interface for PipeWire volume controls
  ];

  services.pipewire = {
    enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };

    pulse.enable = true;

    wireplumber.enable = true;
  };
}
