{
  pkgs,
  user,
  ags,
  ...
}: {
  home-manager.users.${user.name} = {
    imports = [ags.homeManagerModules.default];

    programs.ags = {
      enable = true;
      configDir = ./.;

      # additional packages to add to gjs's runtime
      extraPackages = with pkgs; [
        gnome.gvfs
        #gtksourceview
        #webkitgtk
        #accountsservice
      ];
    };
  };
}
