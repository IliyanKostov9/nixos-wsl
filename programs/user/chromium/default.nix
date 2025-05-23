{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.chromium;
in {
  options.modules.chromium = {enable = mkEnableOption "chromium";};

  config = mkIf cfg.enable {
    programs.chromium = {
      enable = true;
      extensions = [
        # Passbolt
        "didegimhafipceonhjepacocaffmoppf"
        # Dark reader
        "eimadpbcbfnmbkopoojfekhnkhdbieeh"
        # Ublock origin
        "ddkjiahejlhfcafbddmgiahcphecmpfh"
        # Privacy Badger
        "pkehgijcmpdhfbdbbnkijodmdjhbjlgp"
        # I don't care about cookies
        "fihnjjcciajhdojfnbdddfaoknhalnja"
        # Canvas blocker
        # "nomnklagbgmgghhjidfhnoelnjfndfpd"
      ];
    };
  };
}
