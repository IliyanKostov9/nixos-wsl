{
  pkgs,
  users,
  ...
}: {
  # NOTE: REQUIRED: for initialHashedPassword
  users.mutableUsers = false;
  users.users =
    builtins.mapAttrs
    (
      _: user-attr: {
        inherit (user-attr) initialHashedPassword;
        shell = pkgs.zsh;
        createHome = true;
        isNormalUser = true;
        description = "user";
        extraGroups = ["wheel"];
      }
    )
    users;
}
