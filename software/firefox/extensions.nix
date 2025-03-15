{
  pkgs,
  user,
  ...
}: {
  # Mostly using the descriptions of Rycee firefox-addons repository
  user-manage.programs.firefox.profiles.${user.name}.extensions = with pkgs.nur.repos.rycee.firefox-addons; [
    darkreader # Dark mode for every website
    privacy-badger # Automatically learns to block invisible trackers
    return-youtube-dislikes # Returns ability to see dislike statistics on youtube
    stylus # Customize the look of any website
    tampermonkey # Userscript management
    ublock-origin # Efficient ad blocker
    video-downloadhelper # Download videos from the web. Easy, smart, no tracking
    youtube-shorts-block # Play the Youtube shorts video as if it were a normal video.and hide “shorts" tab and videos (optional)
    wappalyzer # Identify technologies on websites
  ];

  # IN CASE IS NEEDED IN THE FUTURE: https://discourse.nixos.org/t/add-custom-addons-to-firefox-directly-from-https-addons-mozilla-org/48730
}
