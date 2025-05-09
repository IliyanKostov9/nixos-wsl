{
  self,
  inputs,
  ...
}: let
  shared =
    import ./shared.nix
    {
      inherit inputs;
    };
in {
  flake.homeConfigurations =
    builtins.mapAttrs
    (user: _user-attr:
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit (shared) pkgs;
        extraSpecialArgs = {
          inherit self user;
          inherit (shared) system stateVersion;
        };
        modules = [
          ../home
        ];
      })
    shared.users;
}
