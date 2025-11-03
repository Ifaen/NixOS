{
  lib,
  config,
  user,
  pkgs,
  ...
}: {
  options.wireguard.enable = lib.mkEnableOption "Enable WireGuard";

  config = lib.mkIf config.wireguard.enable {
    systemd.services."netns@" = {
      description = "%I network namespace";
      # Delay network.target until this unit has finished starting up.
      before = ["network.target"];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        PrivateNetwork = true;
        ExecStart = "${pkgs.writers.writeDash "netns-up" ''
          ${pkgs.iproute}/bin/ip netns add $1
          ${pkgs.utillinux}/bin/umount /var/run/netns/$1
          ${pkgs.utillinux}/bin/mount --bind /proc/self/ns/net /var/run/netns/$1
        ''} %I";
        ExecStop = "${pkgs.iproute}/bin/ip netns del %I";
        # This is required since systemd commit c2da3bf, shipped in systemd 254.
        # See discussion at https://github.com/systemd/systemd/issues/28686
        PrivateMounts = false;
      };
    };
  };
}
