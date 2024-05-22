# Business Aventuras patagonia linktr.ee/aventuraspatagonia
{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    profiles."aventuraspatagonia" = {
      bookmarks = [
        /*
        {
          name = "";
          toolbar = true;
          bookmarks = [
            {
              name = "";
              url = "";
              keyword = "";
            }
          ];
        }
        */
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
              url = "https://www.linkedin.com/in/aventuraspatagonia";
              keyword = "in";
            }
            {
              name = "Instagram";
              url = "https://instagram.com/aventuras_en_la_patagonia";
              keyword = "insta";
            }
            {
              name = "TikTok";
              url = "https://www.tiktok.com/";
              keyword = "tt";
            }
            {
              name = "Twitter";
              url = "https://twitter.com/cabalgatas_puq";
              keyword = "twt";
            }
            {
              name = "Facebook";
              url = "https://facebook.com/aventuraspatagonia";
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
          ];
        }
      ];
      settings = {
        "browser.startup.page" = 3; # 3 to resume previous tabs. Default: 1
        "browser.translations.enable" = false;
        "browser.aboutConfig.showWarning" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "trailhead.firstrun.didSeeAboutWelcome" = true;
      };
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        keepassxc-browser
      ];
    };
  };

  programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite = {"class<firefox>" = "";}; # nf-fa-suitcase
}
