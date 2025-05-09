{
  pkgs,
  stateVersion,
  ...
}: {
  imports = [
    <nixos-wsl/modules>
    ./programs/system
    ./hosts/system/users
  ];
  wsl = {
    enable = true;
    defaultUser = "nixos";
  };
  nix.settings.experimental-features = ["nix-command" "flakes"];
  system = {
    inherit stateVersion;
  };
}
