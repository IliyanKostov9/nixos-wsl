{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.docker;
in {
  options.modules.docker = {enable = mkEnableOption "docker";};

  config = mkIf cfg.enable {
    home.packages = builtins.attrValues {
      inherit
        (pkgs)
        docker
        lazydocker
        docker-buildx
        docker-credential-helpers
        ;
      # nerdctl
    };
  };
}
