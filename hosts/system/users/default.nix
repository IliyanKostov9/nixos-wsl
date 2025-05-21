{
  pkgs,
  users,
  ...
}: {
  users.users =
    builtins.mapAttrs
    (
      _: user-attr: {
        shell = pkgs.zsh;
        createHome = true;
        isNormalUser = true;
        description = "user";
        extraGroups = ["wheel" "docker"];
      }
    )
    users;
}
