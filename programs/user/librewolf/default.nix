{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.librewolf;
in {
  options.modules.librewolf = {enable = mkEnableOption "librewolf";};

  config = mkIf cfg.enable {
    programs.librewolf = {
      enable = true;
      settings = {
        identity.fxaccounts.enabled = false;
        middlemouse.paste = false;
        general.autoScroll = true;
        toolkit.legacyUserProfileCustomizations.stylesheets = true;
        webgl.disabled = false;
        network.cookie.lifetimePolicy = 0;
        geo.enabled = false;

        sidebar = {
          # NOTE: Enable vertical tabs
          verticalTabs = true;
          revamp = true;
          visibility = "always-show";
          main.tools = "aichat,history";
          position_start = true;
        };

        browser = {
          tabs = {
            warnOnClose = false;
            tabmanager.enabled = false;
            hoverPreview.showThumbnails = false;
          };
          contentblocking.category = "strict";
          download.panel.shown = true;
          toolbars.bookmarks.visibility = "newtab";
          sessionstore.restore_pinned_tabs_on_demand = true;
          # NOTE: Disable mini-window preview when hovering over tab
          firefox-view.virtual-list.enabled = false;
          urlbar.suggest = {
            pocket = false;
            bookmark = true;
            engines = true;
            history = true;
            openpage = true;
            topsites = true;
          };
        };

        extensions = {
          autoDisableScopes = 0;
          pocket = {
            enabled = false;
            showHome = true;
          };
        };

        privacy = {
          # NOTE: Dark reader is unable to work if it's enabled
          resistFingerprinting = false;
          clearOnShutdown = {
            history = false;
            downloads = false;
            cookies = false;
          };
        };
      };
      search = {
        force = true;
        default = "Mullvad-Leta";
        privateDefault = "Mullvad-Leta";
        engines = {
          DuckDuckGo = {
            urls = lib.singleton {
              template = "https://duckduckgo.com";

              params = lib.singleton {
                name = "q";
                value = "{searchTerms}";
              };
            };
          };
          Mullvad-Leta = {
            urls = lib.singleton {
              template = "https://leta.mullvad.net/";

              params = lib.singleton {
                name = "q";
                value = "{searchTerms}";
              };
            };
          };
        };
      };
    };
  };
}
