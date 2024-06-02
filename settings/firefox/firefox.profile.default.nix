# Business Aventuras patagonia linktr.ee/aventuraspatagonia
{
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user.name}.programs.firefox.profiles.${user.name} = {
    id = 0;

    search.default = "DuckDuckGo";

    userChrome = ''
      #TabsToolbar, #sidebar-header {
        display: none !important;
      }
      #titlebar {
        visibility: collapse;
      }
    '';

    bookmarks = [
      {
        name = "Social Media";
        toolbar = true;
        bookmarks = [
          {
            name = "Whatsapp";
            url = "https://web.whatsapp.com";
            keyword = "wsp";
          }
          {
            name = "Linkedin";
            url = "https://www.linkedin.com";
            keyword = "in";
          }
          {
            name = "Instagram";
            url = "https://instagram.com";
            keyword = "insta";
          }
          {
            name = "TikTok";
            url = "https://www.tiktok.com";
            keyword = "tt";
          }
          {
            name = "Twitter";
            url = "https://twitter.com";
            keyword = "twt";
          }
          {
            name = "Facebook";
            url = "https://facebook.com";
            keyword = "face";
          }
        ];
      }
      {
        name = "Tools";
        toolbar = true;
        bookmarks = [
          {
            name = "Canva";
            url = "https://www.canva.com/";
            keyword = "canva";
          }
          {
            name = "GitLab";
            url = "https://gitlab.com/aventuras-en-la-patagonia/Webpage";
            keyword = "glab";
          }
          {
            name = "Tabler.io";
            url = "tabler.io/icons";
            keyword = "icons";
          }
        ];
      }
    ];
  };
}
