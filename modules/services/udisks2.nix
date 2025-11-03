{...}: {
  services.udisks2 = {
    enable = true;

    # When enabled, instructs udisks2 to mount removable drives under /media/ directory, instead of the default /run/media/$USER/
    mountOnMedia = false;
  };
}
