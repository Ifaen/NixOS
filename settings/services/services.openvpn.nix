{user, ...}: {
  services.openvpn.servers.protonvpn = {
    autoStart = false;

    config = "config ${user.home}/Documents/Services/Internet/VPN/protonvpn.udp.ovpn";

    updateResolvConf = true;
  };
}
