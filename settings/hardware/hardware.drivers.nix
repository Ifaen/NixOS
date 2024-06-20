{
  config,
  pkgs,
  user,
  ...
}: {
  config =
    {
      zramSwap.enable = true; # Enable the usage of zram instead of swap memory

      # Using cpufreq-info | grep "governor" in nix-shell -p cpufrequtils, outputs available options. When doing cat
      # /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor, the output was powersave which made the system slower in theory.
      powerManagement.cpuFreqGovernor = "performance";
    }
    // (
      if user.machine == "desktop"
      then {
        boot.supportedFilesystems = ["ntfs"]; # Allow the support for windows file system

        # Drivers
        boot = {
          #kernelPackages = ;
          kernelModules = ["amdgpu"]; # To boot kernel with amd module
        };

        hardware.opengl = {
          enable = true; # Mesa

          driSupport = true; # radv: an open-source Vulkan driver from freedesktop
          driSupport32Bit = true; # radv support for 32 bits applications
        };
      }
      else {}
    );
}
