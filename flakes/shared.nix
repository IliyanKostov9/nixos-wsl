{inputs}:
with inputs; rec {
  system = "x86_64-linux";
  stateVersion = "25.05";
  pkgs =
    import
    nixpkgs
    {
      inherit system;
      config = {allowUnfree = true;};
      overlays = [
        nur.overlays.default
      ];
    };
  config_system =
    import
    ../config.nix {};
  inherit (config_system) users;
}
