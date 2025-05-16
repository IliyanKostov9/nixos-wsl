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
    ./hosts/system/env-vars
  ];
  wsl = {
    enable = true;
    defaultUser = "nixos";
    # NOTE: For /etc/hosts
    wslConf.network.generateHosts = true;
  };
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    steam-run
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];
  system = {
    inherit stateVersion;
  };
}
