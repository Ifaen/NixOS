{user, ...}: {
  user-manage.programs.firefox.profiles.${user.name} = {
    # Enable to use custom styles
    settings."toolkit.legacyUserProfileCustomizations.stylesheets" = true;

    # Create userChrome.css file
    userChrome = ''
      /* Pinned tabs */
      .tabbrowser-tab[pinned] {
        max-width: 60px !important; /* default is ~40px */
        min-width: 60px !important;
      }
      .tabbrowser-tab[pinned] .tab-label {
        color: transparent !important;
      }
      .tabbrowser-tab[pinned] .tab-icon-image {
        margin-left: 10px !important;
        margin-right: 0 !important;
        display: block !important;
      }

      /* Hide close, alltabs and menu button */
      .titlebar-buttonbox-container .titlebar-close,
      #alltabs-button,
      #PanelUI-button {
        display: none !important;
      }
    '';
  };
}
