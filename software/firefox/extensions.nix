{
  inputs,
  pkgs,
  user,
  ...
}: let
  # Code obtained from: https://gitlab.com/rycee/nur-expressions/-/blob/master/pkgs/firefox-addons/default.nix
  buildFirefoxXpiAddon = pkgs.lib.makeOverridable ({
    pname,
    version,
    addonId,
    url,
    sha256,
    meta,
    ...
  }:
    pkgs.stdenv.mkDerivation {
      name = "${pname}-${version}";

      inherit meta;

      src = pkgs.fetchurl {inherit url sha256;};

      preferLocalBuild = true;
      allowSubstitutes = true;

      passthru = {inherit addonId;};

      buildCommand = ''
        dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
        mkdir -p "$dst"
        install -v -m644 "$src" "$dst/${addonId}.xpi"
      '';
    });
in {
  # Mostly using the descriptions of Rycee firefox-addons repository
  user-manage.programs.firefox.profiles.${user.name}.extensions =
    # Getting addons from Rycee NUR
    (with pkgs.nur.repos.rycee.firefox-addons; [
      darkreader # Dark mode for every website
      istilldontcareaboutcookies # Get rid of cookie warnings
      languagetool # AI-Based grammar checker
      privacy-badger # Automatically learns to block invisible trackers
      pywalfox # Pywal integration
      return-youtube-dislikes # Returns ability to see dislike statistics on youtube
      stylus # Customize the look of any website
      tampermonkey # Userscript management
      ublock-origin # Efficient ad blocker
      video-downloadhelper # Download videos from the web. Easy, smart, no tracking
      youtube-shorts-block # Play the Youtube shorts video as if it were a normal video.and hide “shorts" tab and videos (optional)
    ])
    # Manually added addons
    ++ [
      # Visual bookmarks
      (buildFirefoxXpiAddon rec {
        pname = "visual_bookmarks_firefox";
        version = "6.7.0";
        addonId = "{876119d0-ddb9-47bb-9620-bc8d2489e857}"; # Obtained from about:debugging#/runtime/this-firefox after downloading the addon under "Internal UUID"
        url = "https://addons.mozilla.org/firefox/downloads/file/4476258/${pname}-${version}.xpi";
        sha256 = "053r16bzpwxfdppq95rr17qr5v312jl91wmh2rbg9m2lbyx2rhxk"; # Obtained with nix-prefetch-url ${url}
        meta = with pkgs.lib; {
          homepage = "https://addons.mozilla.org/en-US/firefox/addon/visual-bookmarks-firefox/";
          description = "Simple speed dial bookmarks page with search, add, edit, delete, and drag-and-drop functionality.";
        };
      })
    ];
}
