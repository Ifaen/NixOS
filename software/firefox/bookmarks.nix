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
          name = "Homepage";
          keyword = "nixorg";
          url = "https://nixos.org";
        }
        {
          name = "Wiki";
          keyword = "nwiki";
          url = "https://wiki.nixos.org";
        }
        {
          name = "Nix packages";
          keyword = "np";
          url = "https://search.nixos.org/packages?channel=unstable";
        }
        {
          name = "Github Repository";
          keyword = "nrepo";
          url = "https://github.com/NixOS/nixpkgs";
        }
        {
          name = "Nix hub";
          keyword = "nhub";
          url = "https://www.nixhub.io";
        }
        {
          name = "NUR";
          keyword = "nur";
          url = "https://nur.nix-community.org";
        }
        {
          name = "MyNixOS";
          keyword = "myn";
          url = "https://mynixos.com";
        }
        {
          name = "Nix documentation";
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
      name = "Firefox sites";
      bookmarks = [
        {
          name = "Firefox Configuration";
          keyword = "config";
          url = "about:config";
        }
      ];
    }
    {
      name = "Entertainment";
      bookmarks = [
        {
          name = "Youtube";
          keyword = "yt";
          url = "https://www.youtube.com";
        }
        {
          name = "Twitch";
          keyword = "twi";
          url = "https://www.twitch.tv";
        }
        {
          name = "Netflix";
          url = "https://www.netflix.com";
        }
        {
          name = "Natomanga";
          keyword = "nato";
          url = "https://natomanga.com";
        }
        {
          name = "ZonaTMO";
          keyword = "tmo";
          url = "https://zonatmo.com";
        }
        {
          name = "JKanime";
          keyword = "jka";
          url = "https://jkanime.net";
        }
      ];
    }
    {
      name = "Social Media";
      bookmarks = [
        {
          name = "Whatsapp Web";
          keyword = "wsp";
          url = "https://web.whatsapp.com";
        }
        {
          name = "Instagram";
          keyword = "insta";
          url = "https://www.instagram.com";
        }
        {
          name = "Reddit";
          keyword = "redd";
          url = "https://www.reddit.com";
        }
        {
          name = "Facebook";
          keyword = "face";
          url = "https://www.facebook.com";
        }
        {
          name = "LinkedIn";
          url = "https://www.linkedin.com";
        }
        {
          name = "TikTok";
          url = "https://www.tiktok.com/explore";
        }
        {
          name = "X";
          keyword = "x";
          url = "https://x.com";
        }
      ];
    }
    {
      name = "Project Management";
      bookmarks = [
        {
          name = "Atlassian";
          url = "https://www.atlassian.com";
        }
        {
          name = "Gitlab";
          keyword = "glab";
          url = "https://gitlab.com";
        }
        {
          name = "Github";
          keyword = "ghub";
          url = "https://github.com";
        }
      ];
    }
    {
      name = "Tools";
      bookmarks = [
        {
          name = "ChatGPT";
          keyword = "gpt";
          url = "https://chatgpt.com";
        }
        {
          name = "MockAPI";
          url = "https://mockapi.io";
        }
        {
          name = "Image Resizer";
          url = "https://imageresizer.com";
        }
        {
          name = "Background Remover";
          url = "https://www.remove.bg";
        }
        {
          name = "Watermark Remover";
          url = "https://www.watermarkremover.io";
        }
        {
          name = "Files Converter";
          url = "https://anyconv.com";
        }
        {
          name = "Draw.io";
          url = "https://app.diagrams.net";
        }
        {
          name = "Google Translate";
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
          name = "World Time Buddy";
          url = "https://www.worldtimebuddy.com";
        }
        {
          # To check and possible find dev jobs
          name = "Devjobs Scanner";
          url = "https://www.devjobsscanner.com";
        }
        {
          # To check if certain mail have been pwned
          name = "haveibeenpwned";
          url = "https://haveibeenpwned.com";
        }
        {
          # Compare electronics prices
          name = "SoloTodo";
          url = "https://www.solotodo.cl";
        }
        {
          # Cloud storage
          name = "Proton Drive";
          url = "https://drive.proton.me";
        }
        {
          # Cloud storage
          name = "Google Drive";
          url = "https://drive.google.com";
        }
        {
          # Maps
          name = "Google Maps";
          url = "https://maps.google.com";
        }
      ];
    }
    {
      name = "Services";
      bookmarks = [
        {
          name = "Syncthing";
          keyword = "sync";
          url = "http://localhost:8384";
        }
        {
          name = "Google Firebase";
          url = "https://firebase.google.com";
        }
      ];
    }
    {
      name = "E-Commerce";
      bookmarks = [
        {
          name = "AliExpress";
          url = "https://aliexpress.com";
        }
        {
          name = "Temu";
          url = "https://www.temu.com";
        }
        {
          name = "MercadoLibre";
          url = "https://www.mercadolibre.cl";
        }
      ];
    }
    {
      name = "Wallpapers";
      bookmarks = [
        {
          name = "4K Wallpapers";
          url = "https://4kwallpapers.com";
        }
        {
          name = "Artstation";
          url = "https://www.artstation.com";
        }
        {
          name = "Wallhaven";
          url = "https://wallhaven.cc";
        }
      ];
    }
    {
      name = "Icons";
      bookmarks = [
        {
          name = "Tabler Icons";
          url = "https://tabler.io/icons";
        }
        {
          name = "Flaticon";
          url = "https://www.flaticon.com";
        }
        {
          name = "Heroicons";
          url = "https://heroicons.com";
        }
        {
          name = "Icons8";
          url = "https://icons8.com";
        }
        # Glyphs
        {
          name = "Nerd Fonts";
          url = "https://www.nerdfonts.com/cheat-sheet";
        }
        {
          name = "FontAwesome";
          url = "https://fontawesome.com";
        }
      ];
    }
    {
      name = "Games Related";
      bookmarks = [
        {
          name = "Steam";
          url = "https://store.steampowered.com";
        }
      ];
    }
    {
      name = "Country Wide";
      bookmarks = [
        {
          name = "AyudaMineduc";
          url = "https://ayudamineduc.cl";
        }
      ];
    }
  ];
}
