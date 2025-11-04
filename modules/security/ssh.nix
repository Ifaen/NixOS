{user, ...}: {
  programs.ssh = {
    extraConfig =
      ''
        Host gitlab.com
          User git
          IdentityFile ~/.ssh/gitlab
      ''
      ++ (
        if user.hostname == "desktop"
        then ''
          Host homelab
            Hostname 192.168.1.16
            Port 5432
            User sfuentes
            IdentityFile ~/.ssh/homelab
        ''
        else ""
      );
  };
}
