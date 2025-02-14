{
  lib,
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

  environment = {
    pathsToLink = ["/share/xdg-desktop-portal" "/share/applications"];

    # Re-direct variable towards the correct path so the xdg-desktop-portal.service finds the DE-portals.conf
    sessionVariables =
      {
        NIXOS_XDG_DESKTOP_PORTAL_CONFIG_DIR = "${user.config}/xdg-desktop-portal";
      }
      // lib.optionalAttrs (user.machine == "wsl") {
        XDG_CURRENT_DESKTOP = "GNOME";
        XDG_SESSION_TYPE = "wayland";
      };
  };

  user-manage =
    {
      xdg.portal =
        {
          enable = true;
          xdgOpenUsePortal = true;
        }
        // (
          if (user.machine != "wsl")
          then {
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
          }
          else {
            extraPortals = [pkgs.xdg-desktop-portal-gtk];

            config."GNOME" = {
              default = ["gtk"];

              "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
            };
          }
        );
    }
    // lib.optionalAttrs (user.machine != "wsl") {
      hyprland.windowrulev2 = map (rule: rule + ", class:(.*dg-desktop-portal.*)") [
        "float"
        "focusonactivate"
        "center 1"
      ];

      waybar-workspace-icon."class<.*dg-desktop-portal.*>" = "";
    };
}
