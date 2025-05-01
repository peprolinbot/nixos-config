{
  pkgs,
  inputs,
  ...
}: {
  programs.librewolf = {
    enable = true;
    settings = {
      "webgl.disabled" = false;
      # "privacy.resistFingerprinting" = false;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.cookies" = false;
      "network.cookie.lifetimePolicy" = 0;
      "identity.fxaccounts.enabled" = true;
    };
    profiles.pedro = {
      search = {
        force = true;
        default = "FruesX";
        privateDefault = "FruesX";
        order = ["FruesX" "DuckDuckGo" "Google"];
        engines = {
          "FruesX" = {
            urls = [{template = "https://searx.peprolinbot.com/search?q={searchTerms}";}];
            iconUpdateURL = "https://searx.peprolinbot.com/favicon.ico";
          };
        };
      };
      bookmarks = {};
      extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
        # ublock-origin # Included in Librewolf
        bitwarden
        skip-redirect
        libredirect
        multi-account-containers
        clearurls
        hoppscotch
      ];
      bookmarks = {};
      settings = {
        # Sync settings
        "services.sync.engine.addresses" = false;
        "services.sync.engine.bookmarks" = true;
        "services.sync.engine.creditcards" = false;
        "services.sync.engine.history" = true;
        "services.sync.engine.passwords" = false;
        "services.sync.engine.prefs" = false;
        "services.sync.engine.tabs" = true;

        # Layout
        "browser.uiCustomization.state" = builtins.toJSON {
          currentVersion = 20;
          newElementCount = 5;
          dirtyAreaCache = ["nav-bar" "PersonalToolbar" "toolbar-menubar" "TabsToolbar" "widget-overflow-fixed-list"];
          placements = {
            PersonalToolbar = ["personal-bookmarks"];
            TabsToolbar = ["tabbrowser-tabs" "new-tab-button" "alltabs-button"];
            nav-bar = [
              "back-button"
              "forward-button"
              "stop-reload-button"
              "urlbar-container"
              "downloads-button"
              "ublock0_raymondhill_net-browser-action" # uBlock
              "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action" # Bitwarden
              "7esoorv3_alefvanoon_anonaddy_me-browser-action" # LibRedirect
              "_testpilot-containers-browser-action" # Multi-account containers
              "unified-extensions-button" # Button with the rest of extensions
            ];
            toolbar-menubar = ["menubar-items"];
            unified-extensions-area = [];
            widget-overflow-fixed-list = [];
          };
          seen = ["developer-button" "ublock0_raymondhill_net-browser-action" "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action" "_testpilot-containers-browser-action"];
        };
      };
    };
  };
}
