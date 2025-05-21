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
        homepageLocation = "https://duckduckgo.com";
        defaultSearchProviderSearchURL = "https://duckduckgo.com/?t=h_&q={searchTerms}";
        defaultSearchProviderSuggestURL = "https://duckduckgo.com/?t=h_&q={searchTerms}";
        extensions = [
          # Dark reader
          "eimadpbcbfnmbkopoojfekhnkhdbieeh"
          # Ublock origin
          "ddkjiahejlhfcafbddmgiahcphecmpfh"
          # Privacy Badger
          "pkehgijcmpdhfbdbbnkijodmdjhbjlgp"
          # User agent switcher
          "bhchdcejhohfmigjafbampogmaanbfkg"
          # I don't care about cookies
          "fihnjjcciajhdojfnbdddfaoknhalnja"
          # Canvas blocker
          # "nomnklagbgmgghhjidfhnoelnjfndfpd"
        ];
      };
        };
  };
