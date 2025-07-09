{
  pkgs,
  user,
  ...
}: {
  user-manage.programs.firefox.profiles.${user.name}.search = {
    force = true;
    default = "ddg";
    engines = {
      nix-packages = {
        name = "Nix Packages";
        urls = [
          {
            template = "https://search.nixos.org/packages";
            params = [
              {
                name = "type";
                value = "packages";
              }
              {
                name = "query";
                value = "{searchTerms}";
              }
            ];
          }
        ];

        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = ["@np"];
      };

      nixos-wiki = {
        name = "NixOS Wiki";
        urls = [{template = "https://wiki.nixos.org/w/index.php?search={searchTerms}";}];
        iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
        definedAliases = ["@nw"];
      };

      bing.metaData.hidden = true;
      google.metaData.alias = "@g"; # builtin engines only support specifying one additional alias
    };
  };
}
