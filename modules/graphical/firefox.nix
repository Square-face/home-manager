{ config, lib, pkgs, ... }: {
  options.firefox.enable = lib.mkEnableOption "Enable firefox";
  config = lib.mkIf (config.firefox.enable && config.graphical.enable) {
    programs.firefox.enable = true;
    programs.firefox.package = pkgs.librewolf;
    programs.firefox.policies = {

      # Fine
      HardwareAcceleration = true;
      PictureInPicture = {
        Enabled = true;
        Locked = true;
      };
      EncryptedMediaExtensions = {
        Enabled = true;
        Locked = true;
      };

      # Imagine having a imperative browser
      AppAutoUpdate = false; 
      BackgroundAppUpdate = false; 

      # Attention whore
      DontCheckDefaultBrowser = true; 
      UserMessaging = {
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        Locked = true;
        MoreFromMozilla = false;
        SkipOnboarding = true;
        UrlbarInterventions = false;
        WhatsNew = false;
      };

      DisableFirefoxStudies = true;
      DisableFirefoxAccounts = true; 
      DisableFirefoxScreenshots = true; 
      DisableMasterPasswordCreation = true; 
      DisableProfileImport = true; 
      DisableProfileRefresh = true; 
      DisableSetDesktopBackground = true; 
      DisplayMenuBar = "default-off";
      DisablePocket = true;
      DisableTelemetry = true;
      DisableFormHistory = true;
      DisablePasswordReveal = true;
      SearchSuggestEnabled = false;

      # Declutter
      ShowHomeButton = false;
      NoDefaultBookmarks = true;
      DisableForgetButton = true; 

      # Bitwarden does it better
      OfferToSaveLogins = false; 
      PasswordManagerEnabled = false; # Managed by KeepAss

      # just use evince bro
      DisableBuiltinPDFViewer = true; 
      PDFjs = {
        Enabled = false;
        EnablePermissions = false;
      };

      # Extensions lockdown
      ExtensionUpdate = false;
      ExtensionSettings = {
        "*" = {
          installation_mode = "blocked";
          blocked_install_message = "Nuh Uh";
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4493940/bitwarden_password_manager-2025.12.1.xpi";
          installation_mode = "force_installed";
        };
        "uBlock0@raymondhill.net" = {
          # uBlock Origin
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4492375/ublock_origin-1.68.0.xpi";
          installation_mode = "force_installed";
        };
      };

      "3rdparty".Extensions = {
        "uBlock0@raymondhill.net".adminSettings = {
          userSettings = rec {
            uiTheme = "dark";
            uiAccentCustom = true;
            uiAccentCustom0 = "#8300ff";
            cloudStorageEnabled = false; # Security liability?
            importedLists = [
              "https://filters.adtidy.org/extension/ublock/filters/3.txt"
              "https://github.com/DandelionSprout/adfilt/raw/master/LegitimateURLShortener.txt"
            ];
            externalLists = lib.concatStringsSep "\n" importedLists;
          };
          whitelist = [
            "chrome-extension-scheme"
            "moz-extension-scheme"
            "www.youtube.com" # Youtube premium
          ];
          selectedFilterLists = [
            "CZE-0"
            "adguard-generic"
            "adguard-annoyance"
            "adguard-social"
            "adguard-spyware-url"
            "easylist"
            "easyprivacy"
            "https://github.com/DandelionSprout/adfilt/raw/master/LegitimateURLShortener.txt"
            "plowe-0"
            "ublock-abuse"
            "ublock-badware"
            "ublock-filters"
            "ublock-privacy"
            "ublock-quick-fixes"
            "ublock-unbreak"
            "urlhaus-1"
          ];
        };
      };

      # Not cool mozilla
      FirefoxHome = {
        Search = true;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
        Locked = true;
      };
      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
        Locked = true;
      };

      # Privacy settings
      SearchEngines = {
        PreventInstalls = true;
        Default = "DuckDuckGo";
      };
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
      };
      SanitizeOnShutdown = {
        Cache = true;
        Cookies = false;
        Downloads = true;
        FormData = true;
        History = true;
        Sessions = false;
        SiteSettings = true;
        OfflineApps = true;
        Locked = true;
      };

      StartDownloadsInTempDirectory = true; # zoomies
    };
  };
}
