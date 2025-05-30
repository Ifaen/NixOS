{
  pkgs,
  user,
  ...
}: {
  user-manage = let
    hexperiment = pkgs.fetchFromGitHub {
      owner = "kando-menu";
      repo = "menu-themes";
      rev = "39ce2639a7413d5ccf3b50a2b87e58727eaf2ad9";
      sha256 = "sha256-cdx4YX73nH3tEisR0p4xQU889Dz4kpgGr68JARbIXp4=";
    };
  in {
    home.packages = [
      pkgs.kando
      pkgs.gnomeExtensions.kando-integration # Allows kando to work in wayland
    ];

    hyprland = {
      exec-once = ["kando"];

      windowrulev2 = map (rule: rule + ", class:(kando)") [
        "float"
        "pin"
        "size 100% 100%"
        "noblur"
        "noborder"
        "noanim"
        "opaque"
      ];
    };

    xdg.configFile."kando/menu-themes/hexperiment".source = "${hexperiment}/themes/hexperiment"; # Theme for kando
  };
}
