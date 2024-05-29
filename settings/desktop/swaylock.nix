{
  pkgs,
  user,
  ...
}: {
  security.pam.services.swaylock = {}; # Essential for swaylock to work properly

  home-manager.users.${user.name}.programs = {
    swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
      settings = {
        ignore-empty-password = true;

        clock = true;
        timestr = "%R";
        datestr = "%a, %e de %B";
        image = "$(cat ${user.home}/.cache/swww/${user.monitor})";

        fade-in = "1"; # Fade in time

        indicator = true; # Show/Hide indicator circle
        indicator-radius = "200"; # indicator size
        indicator-thickness = "20";
        indicator-caps-lock = true;
        disable-caps-lock-text = true;

        key-hl-color = "00000066";
        separator-color = "00000000";

        inside-color = "00000033";
        inside-clear-color = "ffffff00";
        inside-caps-lock-color = "ffffff00";
        inside-ver-color = "ffffff00";
        inside-wrong-color = "ffffff00";

        ring-color = "ffffff";
        ring-clear-color = "ffffff";
        ring-caps-lock-color = "ffffff";
        ring-ver-color = "ffffff";
        ring-wrong-color = "ffffff";

        line-color = "00000000";
        line-clear-color = "ffffffFF";
        line-caps-lock-color = "ffffffFF";
        line-ver-color = "fffffFF";
        line-wrong-color = "ffffffFF";

        text-color = "ffffff";
        text-clear-color = "ffffff";
        text-ver-color = "ffffff";
        text-wrong-color = "ffffff";

        bs-hl-color = "ffffff";
        caps-lock-key-hl-color = "ffffffFF";
        caps-lock-bs-hl-color = "ffffffFF";
        text-caps-lock-color = "ffffff";
      };
    };
  };
}
