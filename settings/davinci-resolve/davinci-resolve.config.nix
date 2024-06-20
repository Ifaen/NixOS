{
  pkgs,
  user,
  ...
}: {
  # Making an overlay
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

  hardware.opengl.extraPackages = [
    pkgs.rocm-opencl-icd
    # TODO Seems to be unnecessary
    #rocm-opencl-runtime
    #rocmPackages.rocm-runtime
    #amdvlk
  ];

  home-manager.users.${user.name} = {
    home.packages = [pkgs.davinci-resolve];

    xdg.desktopEntries.resolve = {
      name = "Davinci Resolve";
      genericName = "Video Editing";
      exec = "env QT_QPA_PLATFORM=xcb davinci-resolve";
      type = "Application";
      categories = ["AudioVideo" "X-VideoEditing"];
      comment = "Professional Video Editing Software";
    };
  };
}
