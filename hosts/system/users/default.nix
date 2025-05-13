{
  pkgs,
  users,
  ...
}: {
  networking.extraHosts = builtins.readFile /home/nixos/Documents/hosts;

  # NOTE: REQUIRED: for initialHashedPassword
  # users.mutableUsers = false;
  users.users =
    builtins.mapAttrs
    (
      _: user-attr: {
        shell = pkgs.zsh;
        createHome = true;
        isNormalUser = true;
        description = "user";
        extraGroups = ["wheel"];
      }
    )
    users;
}
