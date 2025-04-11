{
  inputs,
  user,
  ...
}: {
  user-manage = {
    home.packages = [inputs.astal.packages.${user.system}.default];
  };
}
