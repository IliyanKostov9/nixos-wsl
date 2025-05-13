{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.firefox;
in {
  options.modules.firefox = {enable = mkEnableOption "firefox";};

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      firefox
    ];
  };
}
