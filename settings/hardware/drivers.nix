{
  config,
  lib,
  pkgs,
  user,
  ...
}: {
  zramSwap.enable = true; # Enable the usage of zram instead of swap memory

  boot =
    {
      supportedFilesystems = ["ntfs"]; # Allow the support for windows file system
    }
    // lib.optionalAttrs (user.machine == "desktop") {
      kernelModules = ["amdgpu"]; # To boot kernel with amd module

      kernelParams = ["intel_pstate=active"];
    };

  hardware.graphics =
    {
      enable = true;

      enable32Bit = true; # Support for 32 bits applications
    }
    // lib.optionalAttrs (user.machine == "desktop") {
      extraPackages = [pkgs.amdvlk];

      extraPackages32 = [pkgs.driversi686Linux.amdvlk];
    }
    // lib.optionalAttrs (user.machine == "notebook") {
      # TODO In NixOS Desktop, check if intel igpu is enabled, if not, these drivers are not needed there.
      extraPackages = [
        pkgs.intel-media-driver
        pkgs.intel-ocl
      ];
    };
}
