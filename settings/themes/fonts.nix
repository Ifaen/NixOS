{pkgs, ...}: {
  fonts = {
    fontDir.enable = true;

    packages = [pkgs.nerd-fonts.fira-code];
  };
}
