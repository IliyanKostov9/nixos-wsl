{
  inputs,
  config,
  ...
}: let
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
          system = shared.system;
          modules = with inputs; [
            nix-index-database.nixosModules.nix-index
            home-manager.nixosModules.home-manager
            ../configuration.nix
            {
              nixpkgs.pkgs = shared.pkgs;
            }
          ];
          specialArgs = {
            inherit (shared) system stateVersion users;
          };
        }
    )
    shared.users;
}
