{inputs, ...}: let
  shared =
    import ./shared.nix
    {
      inherit inputs;
    };
in {
  flake.nixosConfigurations =
    builtins.mapAttrs
    (
      host_name: host_attr:
        inputs.nixpkgs.lib.nixosSystem {
          modules = [
            inputs.home-manager.nixosModules.home-manager
            ../configuration.nix
          ];
          specialArgs = {
            inherit (shared) pkgs system stateVersion users;
          };
        }
    )
    shared.config_system.users;
}
