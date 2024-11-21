{user, ...}: {
  services.openvpn.servers.protonvpn = {
    autoStart = false;

    config = "config ${user.dir.documents}/Services/Internet/VPN/us.protonvpn.udp.ovpn";

    updateResolvConf = true;
  };
}
