{...}: {
  zramSwap.enable = true; # Enable the usage of zram instead of swap memory

  # Using cpufreq-info | grep "governor" in nix-shell -p cpufrequtils, outputs available options. When doing cat
  # /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor, the output was powersave which made the system slower in theory.
  powerManagement = {
    enable = true;

    cpuFreqGovernor = "performance";
  };

  # Drivers
  boot = {
    kernelModules = ["amdgpu"]; # To boot kernel with amd module

    kernelParams = ["intel_pstate=active"];

    supportedFilesystems = ["ntfs"]; # Allow the support for windows file system
  };

  hardware.graphics = {
    enable = true;

    enable32Bit = true; # Support for 32 bits applications
  };
}
