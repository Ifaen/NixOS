{
  inputs,
  config,
  pkgs,
  ...
}: {
  # Adds unstable packages to the system
  _module.args.unstable-pkgs = import inputs.nixpkgs-unstable {
    inherit (pkgs.stdenv.hostPlatform) system;
    inherit (config.nixpkgs) config;
  };

  nixpkgs.config.allowUnfree = true; # Allows unfree packages for nixpkgs

  home-manager = {
    useUserPackages = false; # If true, moves the home-manager packages from $HOME/.nix-profile to /etc/profiles
    useGlobalPkgs = true; # To use the same nixpkgs configuration as the nixos system

    backupFileExtension = "backup";
  };

  user-manage = {
    home.packages = with pkgs; [
      file # To easily know the mimeapp and more
      brave # Second browser in case primary throws an error
      vdhcoapp # Companion application for the Video DownloadHelper browser add-on.
      wl-clipboard-rs
    ];

    waybar-workspace-icon = {
      "class<org.telegram.desktop>" = " ";
      "class<Brave-browser>" = " ";
    };
  };
}
