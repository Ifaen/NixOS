{
  pkgs,
  user,
  ...
}: {
  # Enable Keyring managing
  services.gnome.gnome-keyring.enable = true;

  # Add gnome keyring to pam services
  security.pam.services = {
    login.enableGnomeKeyring = true;
    auth.enableGnomeKeyring = true;
  };

  environment.pathsToLink = ["/share/xdg-desktop-portal" "/share/applications"];

  user-manage = {
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;

      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];

      config."hyprland" = {
        default = [
          "hyprland"
          "gtk"
        ];

        "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
      };
    };

    # Re-direct variable towards the correct path so the xdg-desktop-portal.service finds the DE-portals.conf
    home.sessionVariables.NIXOS_XDG_DESKTOP_PORTAL_CONFIG_DIR = "${user.config}/xdg-desktop-portal";

    hyprland.windowrulev2 = let
      commonRules = [
        "float"
        "center 1"
        "size <60% <50%"
      ];
      applyRulesToConditions = conditions:
        builtins.concatLists (map
          (condition: map (rule: rule + ", " + condition) commonRules)
          conditions);
    in
      # Apply common rules to all windows that match the following conditions
      applyRulesToConditions [
        "class:(.*dg-desktop-portal.*)"
        "title:(Save Video)"
        "title:(Save Image)"
      ];

    waybar-workspace-icon."class<.*dg-desktop-portal.*>" = "";
  };
}
