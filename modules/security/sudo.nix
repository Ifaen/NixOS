{
  pkgs,
  user,
  ...
}: {
  security.sudo = {
    enable = true;

    extraRules = [
      {
        users = ["${user.name}"];
        commands = [
          {
            command = "${pkgs.efibootmgr}/bin/efibootmgr";
            options = ["NOPASSWD"];
          }
        ];
      }
    ];
  };
}
