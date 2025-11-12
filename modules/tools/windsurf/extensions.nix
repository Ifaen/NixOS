{
  inputs,
  pkgs,
  ...
}: {
  nixpkgs.overlays = [inputs.nix-vscode-extensions.overlays.default];

  user-manage = {
    # Needed for extensions to work correctly
    home.packages = [
      pkgs.alejandra
      pkgs.nixd
    ];

    programs.vscode.profiles.default.extensions = with pkgs.nix-vscode-extensions.open-vsx;
      [
        jnoortheen.nix-ide # Nix language support. Used with nixd
        kamadorueda.alejandra # Nix formatter
        ms-python.black-formatter # Python formatter
        esbenp.prettier-vscode # Web dev languages formatter (JS, TS, HTML, CSS, JSON)
        pkief.material-icon-theme # Icons
        bradlc.vscode-tailwindcss # Tailwind CSS support
        #heybourn.headwind # Sorting tailwind classes
        bungcip.better-toml # TOML syntax support
        formulahendry.auto-rename-tag # Autorename HTML tags
        tailscale.vscode-tailscale # Needed to connect to server repository
      ]
      # NOTE: dlasagno.wal-theme is installed manually because the wal.json file is incompatible with declarative configuration
      # Extensions obtained directly from marketplace. Used sha256=pkgs.lib.fakeSha256; to get the correct sha256
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        # Toggle settings.json "files.exclude" option
        {
          name = "toggle-excluded-files";
          publisher = "amodio";
          version = "2023.4.1012";
          sha256 = "sha256-j0zAAnaGIzKTlt8QXvaEGwRb8dWnGkcB/2/XVH+lHXQ=";
        }
      ];

    programs.vscode.profiles.default.enableExtensionUpdateCheck = false; # Whether to prevent auto update messages
  };
}
