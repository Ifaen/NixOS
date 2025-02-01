{user, ...}: {
  services.openvpn.servers.protonvpn = {
    autoStart = false;

    /*
    In the file, I commented the following lines:

    #up /etc/openvpn/update-resolv-conf
    #down /etc/openvpn/update-resolv-conf

    And added:

    <auth-user-pass>
    myvpnusername
    myvpnpassword
    </auth-user-pass>
    */
    config = "config ${user.documents}/Services/Internet/VPN/protonvpn.udp.ovpn";

    updateResolvConf = true;
  };
}
