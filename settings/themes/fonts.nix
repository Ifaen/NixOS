{pkgs, ...}: {
  fonts = {
    fontDir.enable = true;

    packages = [pkgs.fira-code-nerdfont];
  };
}
