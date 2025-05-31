{pkgs, ...}: {
  fonts = {
    fontDir.enable = true;

    packages = with pkgs.nerd-fonts; [
      fira-code
      fira-mono
      symbols-only
    ];
  };
}
