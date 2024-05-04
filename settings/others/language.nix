{user, ...}: {
  # Set your time zone.
  time.timeZone = "America/Punta_Arenas";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "es_CL.UTF-8";
      LC_IDENTIFICATION = "es_CL.UTF-8";
      LC_MEASUREMENT = "es_CL.UTF-8";
      LC_MONETARY = "es_CL.UTF-8";
      LC_NAME = "es_CL.UTF-8";
      LC_NUMERIC = "es_CL.UTF-8";
      LC_PAPER = "es_CL.UTF-8";
      LC_TELEPHONE = "es_CL.UTF-8";
      LC_TIME = "es_CL.UTF-8";
    };
  };

  # Layout of the keyboard
  services.xserver.xkb = {
    layout = "${user.language}";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "${user.language}";
}
