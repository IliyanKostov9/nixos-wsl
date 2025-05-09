{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with lib.types; let
  cfg = config.modules.tmux;
in {
  options.modules.tmux = {
    enable = mkOption {
      type = bool;
      default = false;
      description = mkDoc ''
        Enable tmux terminal multiplexer
      '';
    };

    config = mkIf cfg.enable {
      programs.tmux = {
        enable = true;
        plugins = with pkgs.tmuxPlugins; [
          resurrect
          sensible
          yank
          open
        ];
        extraConfig = lib.fileContents ./tmux.conf;
        clock24 = true;
        baseIndex = 1;
        mouse = true;
      };
    };
  };
}
