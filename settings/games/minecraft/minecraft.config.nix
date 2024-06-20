{
  pkgs,
  user,
  ...
}: {
  environment.systemPackages = [pkgs.prismlauncher];

  home-manager.users.${user.name} = {
    xdg.dataFile."PrismLauncher/prismlauncher.cfg" = {
      enable = false;
      text = ''
        [General]
        ApplicationTheme=system
        AutoCloseConsole=false
        CentralModsDir=mods
        CloseAfterLaunch=false
        ConfigVersion=1.2
        ConsoleFont=DejaVu Sans Mono
        ConsoleFontSize=11
        ConsoleMaxLines=100000
        ConsoleOverflowStop=true
        DownloadsDir=${user.home}/Downloads
        DownloadsDirWatchRecursive=false
        EnableFeralGamemode=false
        EnableMangoHud=false
        FlameKeyOverride=
        IconTheme=pe_colored
        IconsDir=icons
        IgnoreJavaCompatibility=false
        IgnoreJavaWizard=false
        InstSortMode=LastLaunch
        InstanceDir=instances
        JavaPath=${pkgs.jdk}/bin/java
        Language=en_US
        LastHostname=desktop
        LaunchMaximized=false
        MaxMemAlloc=4096
        MenuBarInsteadOfToolBar=false
        MinMemAlloc=512
        MinecraftWinHeight=480
        MinecraftWinWidth=854
        ModDependenciesDisabled=false
        ModMetadataDisabled=false
        ModrinthToken=
        NumberOfConcurrentDownloads=6
        NumberOfConcurrentTasks=10
        OnlineFixes=false
        PastebinType=3
        PermGen=128
        PostExitCommand=
        PreLaunchCommand=
        ProxyAddr=127.0.0.1
        ProxyPass=
        ProxyPort=8080
        ProxyType=None
        ProxyUser=
        QuitAfterGameStop=false
        RecordGameTime=true
        ShowConsole=false
        ShowConsoleOnError=true
        ShowGameTime=true
        ShowGameTimeWithoutDays=false
        ShowGlobalGameTime=true
        ToolbarsLocked=false
        UseDiscreteGpu=false
        UseNativeGLFW=false
        UseNativeOpenAL=false
      '';
    };

    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite = {
      "class<org.prismlauncher.PrismLauncher>" = "󰍳"; # nf-md-minecraft
      "class<Minecraft.*>" = "󰍳"; # nf-md-minecraft
    };

    wayland.windowManager.hyprland.settings.windowrulev2 = [
      "tile, class:^(.*Minecraft.*)$"
      "workspace 3, class:^(.*Minecraft.*)$"
      "workspace 3, class:(org.prismlauncher.PrismLauncher)"
    ];
  };
}
