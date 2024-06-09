# Business Aventuras patagonia linktr.ee/aventuraspatagonia
{
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user.name}.programs.firefox.profiles."aventuraspatagonia" = {
    id = 1;

    bookmarks = [
      # Social Media
      {
        name = "Social Media";
        toolbar = true;
        bookmarks = [
          {
            name = "Whatsapp";
            url = "https://web.whatsapp.com/";
            keyword = "wsp";
          }
          {
            name = "Linkedin";
            url = "https://www.linkedin.com/in/aventuras-en-la-patagonia";
            keyword = "in";
          }
          {
            name = "Instagram";
            url = "https://instagram.com/aventuras_en_la_patagonia";
            keyword = "insta";
          }
          {
            name = "TikTok";
            url = "https://www.tiktok.com/@aventuraspatagonia";
            keyword = "tt";
          }
          {
            name = "Twitter";
            url = "https://twitter.com/cabalgatas_puq";
            keyword = "twt";
          }
          {
            name = "Facebook";
            url = "https://web.facebook.com/cabalgataspuq";
            keyword = "face";
          }
        ];
      }
      # Domain
      {
        name = "Domain";
        toolbar = true;
        bookmarks = [
          {
            name = "Email";
            url = "https://email.aventuraspatagonia.com";
            keyword = "email";
          }
          {
            name = "Linktree";
            url = "https://linktr.ee/admin";
            keyword = "tree";
          }
        ];
      }
      # Enterprise
      {
        name = "Enterprise";
        toolbar = false;
        bookmarks = [
          {
            name = "SII";
            url = "https://homer.sii.cl";
            keyword = "sii";
          }
          {
            name = "Tu Empresa en un Dia";
            url = "https://www.registrodeempresasysociedades.cl";
            keyword = "enundia";
          }
          {
            name = "Sernatur";
            url = "https://portalserviciosturisticos.sernatur.cl";
            keyword = "sernatur";
          }
        ];
      }
      # Tools
      {
        name = "Tools";
        toolbar = false;
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
