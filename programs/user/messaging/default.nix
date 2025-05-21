{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.messaging;
in {
  options.modules.messaging = {enable = mkEnableOption "messaging";};

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      whatsie
      viber
    ];
  };
}
