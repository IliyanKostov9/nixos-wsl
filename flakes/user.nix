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
  flake.homeConfigurations.nixos = inputs.home-manager.lib.homeManagerConfiguration {
    modules = [
      ../home.nix
    ];
    extraSpecialArgs = {
      inherit self;
      inherit (shared) system stateVersion pkgs;
    };
  };
}
