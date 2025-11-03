{
  lib,
  config,
  ...
}: {
  options = {
    power-management.enable = lib.mkEnableOption "Enable Power Management";
  };

  config = lib.mkIf config.power-management.enable {
    services.auto-cpufreq = {
      enable = true; # Tool for power management, replaces TLP

      settings = {
        # When using the battery, enter powersave mode
        battery = {
          governor = "powersave";
          turbo = "never";
        };

        # When using a charger, enter performance mode
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };
  };
}
