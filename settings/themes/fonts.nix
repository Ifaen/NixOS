{pkgs, ...}: {
  fonts = {
    fontDir.enable = true;

    packages = with pkgs; [
      fira-code-nerdfont
      kdePackages.breeze-icons
    ];
  };
}
