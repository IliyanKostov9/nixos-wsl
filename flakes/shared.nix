{inputs}:
with inputs; rec {
  system = "x86_64-linux";
  stateVersion = "24.11";
  pkgs =
    import
    nixpkgs
    {
      inherit system;
      config = {allowUnfree = true;};
    };
}
