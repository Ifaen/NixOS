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

    settings = {
      "browser.startup.page" = 3; # 3 to resume previous tabs. Default: 1
      "trailhead.firstrun.didSeeAboutWelcome" = true;
    };

    bookmarks = [
      # Nix
      {
        name = "Nix";
        bookmarks = [
          {
            name = "Nix Packages";
            url = "https://search.nixos.org/packages?channel=unstable";
            keyword = "np";
          }
          {
            name = "MyNixOS";
            url = "https://mynixos.com/";
            keyword = "myn";
          }
        ];
      }
      # Entertainment
      {
        name = "Entertainment";
        bookmarks = [
          {
            name = "Youtube";
            url = "https://www.youtube.com";
            keyword = "yt";
          }
          {
            name = "Manganato";
            url = "https://manganato.com";
            keyword = "manga";
          }
          {
            name = "VisorTMO";
            url = "https://visortmo.com";
            keyword = "visor";
          }
        ];
      }
      # Social Media
      {
        name = "Social Media";
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
      # E-commerce
      {
        name = "E-commerce";
        toolbar = true;
        bookmarks = [
          {
            name = "Solo Todo";
            url = "https://www.solotodo.cl/";
            keyword = "solotodo";
          }
        ];
      }
      # Tools
      {
        name = "Tools";
        bookmarks = [
          {
            name = "Firefox Profiles";
            url = "about:profiles";
            keyword = "prof";
          }
          {
            name = "Canva";
            url = "https://www.canva.com";
            keyword = "canva";
          }
          {
            name = "GitLab";
            url = "https://gitlab.com";
            keyword = "glab";
          }
          {
            name = "Github";
            url = "https://github.com";
            keyword = "ghub";
          }
          {
            name = "Tabler.io";
            url = "tabler.io/icons";
            keyword = "icons";
          }
          {
            name = "ChatGPT";
            url = "https://chatgpt.com";
            keyword = "gpt";
          }
          {
            name = "Atlassian";
            url = "https://www.atlassian.com";
            keyword = "atl";
          }
          {
            name = "Firebase";
            url = "https://firebase.google.com";
            keyword = "fbase";
          }
        ];
      }
      # University
      {
        name = "University";
        bookmarks = [
          {
            name = "Intranet";
            url = "https://portal.unab.cl";
            keyword = "intra";
          }
          {
            name = "CAE";
            url = "http://ingresa.cl";
            keyword = "cae";
          }
        ];
      }
    ];
  };
}
