{
  lib,
  user,
  ...
}: {
  user-manage.programs.firefox.profiles.${user.name}.bookmarks = [
    # MARK: Favorites
    {
      name = "Favorites";
      bookmarks = [
        {
          name = "Youtube";
          url = "https://www.youtube.com";
        }
        {
          name = "Reddit";
          keyword = "redd";
          url = "https://www.reddit.com";
        }
        {
          name = "Natomanga";
          keyword = "manga";
          url = "https://natomanga.com";
        }
        {
          name = "ZonaTMO";
          keyword = "tmo";
          url = "https://zonatmo.com";
        }
      ];
    }
    # MARK: Nix Sites
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
    # MARK: Entertainment
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
          keyword = "manga";
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
    # MARK: Social Media
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
    # MARK: Project Management
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
    # MARK: Tools
    {
      name = "Tools";
      bookmarks = [
        {
          name = "LanguageTool";
          keyword = "lt";
          url = "https://languagetool.org";
        }
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
          name = "Wappalyzer";
          url = "https://www.wappalyzer.com";
        }
        {
          name = "DevEnv";
          url = "https://devenv.sh";
        }
        {
          name = "DirEnv";
          url = "https://direnv.net";
        }
      ];
    }
    # MARK: Utilities
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
      ];
    }
    # MARK: Apps
    {
      name = "Apps";
      bookmarks = [
        {
          name = "Hyprland";
          url = "https://hyprland.org";
        }
      ];
    }
    # MARK: Services
    {
      name = "Services";
      bookmarks = [
        {
          name = "Syncthing";
          keyword = "sync";
          url = "http://localhost:8384";
        }
        {
          name = "Jellyfin";
          keyword = "jelly";
          url = "http://localhost:8096";
        }
      ];
    }
    # MARK: E-Commerce
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
    # MARK: Wallpapers
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
    # MARK: Icons
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
    # MARK: Games Related
    {
      name = "Games Related";
      bookmarks = [
        {
          name = "Steam";
          url = "https://store.steampowered.com";
        }
      ];
    }
    # MARK: Country Wide
    {
      name = "Country Wide";
      bookmarks = [
        {
          name = "AyudaMineduc";
          url = "https://ayudamineduc.cl";
        }
        {
          name = "Banco de Chile";
          url = "https://bancochile.cl";
        }
        {
          name = "Banco Estado";
          url = "https://www.bancoestado.cl";
        }
      ];
    }
    # MARK: Linux Sites
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
    # MARK: Firefox Sites
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
    # MARK: Google Sites
    {
      name = "Google Sites";
      bookmarks = [
        {
          name = "Google Translate";
          keyword = "trad";
          url = "https://translate.google.com";
        }
        {
          name = "Google Maps";
          keyword = "gmaps";
          url = "https://maps.google.com";
        }
        {
          # Cloud storage
          name = "Google Drive";
          url = "https://drive.google.com";
        }
        {
          # Cloud Database
          name = "Google Firebase";
          url = "https://firebase.google.com";
        }
      ];
    }
    # Arr Suite
    {
      name = "Arr Suite";
      bookmarks = [
        {
          name = "Prowlarr";
          url = "http://localhost:9696";
        }
        {
          name = "Radarr";
          url = "http://localhost:7878";
        }
        {
          name = "Sonarr";
          url = "http://localhost:8989";
        }
        {
          name = "Lidarr";
          url = "http://localhost:8686";
        }
        {
          name = "Bazarr";
          url = "http://localhost:6767";
        }
      ];
    }
  ];
}
