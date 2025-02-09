{
  lib,
  user,
  ...
}: {
  user-manage.programs.firefox.profiles.${user.name}.bookmarks = [
    {
      name = "Nix sites";
      bookmarks = [
        {
          name = "homepage";
          keyword = "nixorg";
          url = "https://nixos.org";
        }
        {
          name = "wiki";
          keyword = "nwiki";
          url = "https://wiki.nixos.org";
        }
        {
          name = "nix packages";
          keyword = "np";
          url = "https://search.nixos.org/packages?channel=unstable";
        }
        {
          name = "nixpkgs github repo";
          url = "https://github.com/NixOS/nixpkgs";
        }
        {
          name = "nix hub";
          keyword = "nhub";
          url = "https://www.nixhub.io";
        }
        {
          name = "nur";
          keyword = "nur";
          url = "https://nur.nix-community.org";
        }
        {
          name = "mynixos";
          keyword = "myn";
          url = "https://mynixos.com";
        }
        {
          name = "nix documentation";
          url = "https://nlewo.github.io/nixos-manual-sphinx/index.html";
        }
      ];
    }
    {
      name = "Linux sites";
      bookmarks = [
        {
          name = "kernel.org";
          keyword = "kernel";
          url = "https://www.kernel.org";
        }
      ];
    }
    {
      name = "Entertainment";
      bookmarks = [
        {
          name = "youtube";
          keyword = "yt";
          url = "https://www.youtube.com";
        }
        {
          name = "manganato";
          keyword = "manga";
          url = "https://manganato.com";
        }
        {
          name = "zonatmo";
          keyword = "tmo";
          url = "https://zonatmo.com";
        }
        {
          name = "netflix";
          url = "https://www.netflix.com";
        }
        {
          name = "jkanime";
          keyword = "jka";
          url = "https://jkanime.net";
        }
      ];
    }
    {
      name = "Social Media";
      bookmarks = [
        {
          name = "whatsapp web";
          keyword = "wsp";
          url = "https://web.whatsapp.com";
        }
        {
          name = "instagram";
          keyword = "insta";
          url = "https://www.instagram.com";
        }
        {
          name = "reddit";
          keyword = "redd";
          url = "https://www.reddit.com";
        }
        {
          name = "facebook";
          keyword = "face";
          url = "https://www.facebook.com";
        }
        {
          name = "linkedin";
          url = "https://www.linkedin.com";
        }
        {
          name = "tiktok";
          url = "https://www.tiktok.com/explore";
        }
        {
          name = "x";
          keyword = "x";
          url = "https://x.com";
        }
      ];
    }
    {
      name = "Project Management";
      bookmarks = [
        {
          name = "atlassian";
          url = "https://www.atlassian.com";
        }
        {
          name = "gitlab";
          keyword = "glab";
          url = "https://gitlab.com";
        }
        {
          name = "github";
          keyword = "ghub";
          url = "https://github.com";
        }
      ];
    }
    {
      name = "Tools";
      bookmarks = [
        {
          name = "chatgpt";
          keyword = "gpt";
          url = "https://chatgpt.com";
        }
        {
          name = "mockapi";
          url = "https://mockapi.io";
        }
        {
          name = "imresizer";
          url = "https://imresizer.com";
        }
        {
          name = "draw.io";
          url = "https://app.diagrams.net";
        }
        {
          name = "google translate";
          keyword = "trad";
          url = "https://translate.google.com";
        }
      ];
    }
    {
      name = "Utilities";
      bookmarks = [
        {
          # To compare times zones
          name = "world time buddy";
          url = "https://www.worldtimebuddy.com";
        }
        {
          # To check and possible find dev jobs
          name = "devjobs scanner";
          url = "https://www.devjobsscanner.com";
        }
        {
          # To check if certain mail have been pwned
          name = "haveibeenpwned";
          url = "https://haveibeenpwned.com";
        }
        {
          # Compare electronics prices
          name = "solotodo";
          url = "https://www.solotodo.cl";
        }
        {
          # Cloud storage
          name = "google drive";
          url = "https://drive.google.com";
        }
        {
          # Maps
          name = "google maps";
          url = "https://maps.google.com";
        }
      ];
    }
    {
      name = "Services";
      bookmarks = [
        {
          name = "syncthing";
          url = "http://localhost:8384";
        }
        {
          name = "google firebase";
          url = "https://firebase.google.com";
        }
      ];
    }
    {
      name = "E-Commerce";
      bookmarks = [
        {
          name = "aliexpress";
          url = "https://aliexpress.com";
        }
        {
          name = "temu";
          url = "https://www.temu.com";
        }
        {
          name = "mercadolibre";
          url = "https://www.mercadolibre.cl";
        }
      ];
    }
    {
      name = "Wallpapers";
      bookmarks = [
        {
          name = "4kwallpapers";
          url = "https://4kwallpapers.com";
        }
        {
          name = "artstation";
          keyword = "";
          url = "https://www.artstation.com";
        }
        {
          name = "wallhaven";
          url = "https://wallhaven.cc";
        }
      ];
    }
    {
      name = "Icons";
      bookmarks = [
        {
          name = "tabler.io";
          url = "https://tabler.io/icons";
        }
        {
          name = "flaticon";
          url = "https://www.flaticon.com";
        }
        {
          name = "heroicons";
          url = "https://heroicons.com";
        }
        {
          name = "icons8";
          url = "https://icons8.com";
        }
        # Glyphs
        {
          name = "nerdfonts";
          url = "https://www.nerdfonts.com/cheat-sheet";
        }
        {
          name = "fontawesome";
          url = "https://fontawesome.com";
        }
      ];
    }
    {
      name = "Games Related";
      bookmarks = [
        {
          name = "";
          keyword = "";
          url = "";
        }
      ];
    }
    {
      name = "Country Wide";
      bookmarks = [
        {
          name = "ayudamineduc";
          url = "https://ayudamineduc.cl";
        }
      ];
    }
  ];
}
