{
  pkgs,
  stateVersion,
  ...
}: {
  imports = [
    <nixos-wsl/modules>
    ./programs/system
    ./hosts/system/users
    ./hosts/system/network
  ];
  wsl = {
    enable = true;
    defaultUser = "nixos";
    # NOTE: For /etc/hosts
    wslConf.network.generateHosts = true;
  };
  nix.settings.experimental-features = ["nix-command" "flakes"];
  system = {
    inherit stateVersion;
  };
}
