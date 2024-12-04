{pkgs, ...}: {
  # Making an overlay to bind drivers to correct folder
  nixpkgs.overlays = [
    (final: prev: {
      davinci-resolve = prev.davinci-resolve.override (old: {
        buildFHSEnv = a: (old.buildFHSEnv (a
          // {
            extraBwrapArgs =
              a.extraBwrapArgs
              ++ [
                "--bind /run/opengl-driver/etc/OpenCL /etc/OpenCL"
              ];
          }));
      });
    })
  ];

  # allow opencl to detect amd gpu
  hardware.opengl.extraPackages = [pkgs.rocm-opencl-icd];

  user-manage = {
    home.packages = [pkgs.davinci-resolve];

    xdg.desktopEntries.davinci-resolve = {
      name = "Davinci Resolve";
      genericName = "Video Editing";
      exec = "env QT_QPA_PLATFORM=xcb davinci-resolve";
      type = "Application";
      categories = ["X-Rofi" "AudioVideo" "X-VideoEditing"];
      comment = "Professional Video Editing Software";
    };
  };
}
