{
  config,
  lib,
  user,
  ...
}: {
  config =
    {
      zramSwap.enable = true; # Enable the usage of zram instead of swap memory

      # Using cpufreq-info | grep "governor" in nix-shell -p cpufrequtils, outputs available options. When doing cat
      # /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor, the output was powersave which made the system slower in theory.
      powerManagement = {
        enable = true;

        cpuFreqGovernor = "performance";
      };

      boot =
        {
          supportedFilesystems = ["ntfs"]; # Allow the support for windows file system
        }
        // lib.optionalAttrs (user.machine == "desktop") {
          kernelModules = ["amdgpu"]; # To boot kernel with amd module

          kernelParams = ["intel_pstate=active"];
        };
    }
    // lib.optionalAttrs (user.machine == "desktop") {
      hardware.graphics = {
        enable = true;

        enable32Bit = true; # Support for 32 bits applications
      };
    };
}
