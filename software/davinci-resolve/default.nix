{
  lib,
  config,
  pkgs,
  ...
}: {
  options.davinciResolve.enable = lib.mkEnableOption "Enable DaVinci Resolve";

  config = lib.mkIf config.davinciResolve.enable {
    user-manage.home.packages = [pkgs.davinci-resolve];

    user-manage.xdg.desktopEntries."davinci-resolve" = {
      name = "DaVinci Resolve";
      exec = "env ROC_ENABLE_PRE_VEGA=1 RUSTICL_ENABLE=amdgpu,amdgpu-pro,radv,radeon,radeonsi DRI_PRIME=1 QT_QPA_PLATFORM=xcb davinci-resolve";
      icon = "davinci-resolve";
      categories = ["X-Rofi"];
    };

    # Audio support
    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };

    # Drivers
    boot.initrd.kernelModules = ["amdgpu"];

    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        mesa
        libva
        libvdpau-va-gl
        vulkan-loader
        vulkan-validation-layers
        amdvlk # Optional: AMD's proprietary Vulkan driver
        mesa.opencl # Enables Rusticl (OpenCL) support
      ];
    };
  };
}
