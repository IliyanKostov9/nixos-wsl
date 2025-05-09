{inputs, ...}: let
  shared =
    import ./shared.nix
    {
      inherit inputs;
    };
in {
  flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      inputs.home-manager.nixosModules.home-manager
      ../configuration.nix
    ];
    specialArgs = {inherit inputs;};
  };
}
