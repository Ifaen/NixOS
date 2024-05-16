{
  pkgs,
  user,
  ...
}: {
  programs = {
    imv.enable = true;
    ranger = {
      enable = true;
      settings = {
        preview_images = true;
        preview_images_method = "ueberzug";
        use_preview_script = true;
        preview_script = "${user.home}/.config/ranger/scope.sh";
      };
      # Key Bindings
      mappings = {
        "<q>" = "quit";
        "<c-x>" = "console cut";
        "<c-c>" = "console copy";
        "<c-v>" = "console paste";
        "<delete>" = "console delete";
      };
      # Icons
      extraConfig = "default_linemode devicons";
      plugins = [
        {
          name = "ranger_devicons";
          src = pkgs.fetchFromGitHub {
            owner = "alexanderjeurissen";
            repo = "ranger_devicons";
            rev = "ed718dd6a6d5d2c0f53cba8474c5ad96185057e9";
            hash = "sha256-ETE13REDIVuoFIbvWqWvQLj/2fGST+1koowmmuBzGmo=";
          };
        }
      ];
    };
  };

  home.packages = with pkgs; [
    ueberzugpp # To preview images
    ffmpegthumbnailer # To preview videos thumbnails
  ];

  programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite."class<.*ueberzugpp.*>" = "";
}
