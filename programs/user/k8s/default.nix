{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modulesk8s;
in {
  options.modules.k8s = {enable = mkEnableOption "k8s";};

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      kubectl
      # kubectx
      kubernetes-helm
      kind
      # k3s
      # k9s
      # kompose
    ];
  };
}
