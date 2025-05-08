{
  description = "Nix template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    devenv.url = "github:cachix/devenv";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    flake-parts,
    devenv,
    nixpkgs,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux"];
      system = "x86_64-linux";
      stateVersion = "24.11";

      imports =
        [
          inputs.flake-parts.flakeModules.easyOverlay
          inputs.devenv.flakeModule
          # ./flakes/system.nix
          # ./flakes/user.nix
          # ./flakes/export-image.nix
          # ./tests
          ./configuration.nix
        ]
        ++ (
          if !nixpkgs.lib.trivial.inPureEvalMode
          then [
            # ./flakes/dev-shell.nix
          ]
          else nixpkgs.lib.trivial.warn "> Cannot activate devShells while in pure eval mode!" []
        );
    };
}
