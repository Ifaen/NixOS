{pkgs, ...}: {
  user-manage = {
    home.packages = with pkgs.nerd-fonts;
      [
        fira-code
        fira-mono
        symbols-only
      ]
      ++ [pkgs.font-awesome];

    fonts.fontconfig = {
      enable = true;

      defaultFonts = {
        monospace = [
          "FiraCodeNerdFont"
        ];
      };
    };
  };
}
