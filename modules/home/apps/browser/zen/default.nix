{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf optionalAttrs;
  inherit (config.my) apps desktop user;
in
{
  options.my.apps.browser.zen = {
    enable = mkEnableOption "Zen browser";
  };

  config = mkIf apps.browser.zen.enable {
    home-manager.users.${user.name} = {
      imports = [ inputs.zen-browser.homeModules.beta ];

      programs.zen-browser = {
        enable = true;
        nativeMessagingHosts = [ pkgs.firefoxpwa ];

        policies =
          let
            mkLockedAttrs = builtins.mapAttrs (
              _: value: {
                Value = value;
                Status = "locked";
              }
            );

            mkExtensionEntry =
              {
                id,
                pinned ? false,
              }:
              let
                base = {
                  install_url = "https://addons.mozilla.org/firefox/downloads/latest/${id}/latest.xpi";
                  installation_mode = "force_installed";
                };
              in
              if pinned then base // { default_area = "navbar"; } else base;

            mkExtensionSettings = builtins.mapAttrs (
              _: entry: if builtins.isAttrs entry then entry else mkExtensionEntry { id = entry; }
            );
          in
          {
            Preferences = mkLockedAttrs {
              "browser.tabs.warnOnClose" = false;
              "browser.aboutConfig.showWarning" = false;
              "media.videocontrols.picture-in-picture.video-toggle.enabled" = true;
              "browser.gesture.swipe.left" = "";
              "browser.gesture.swipe.right" = "";
              "browser.tabs.hoverPreview.enabled" = true;
            };

            ExtensionSettings = mkExtensionSettings {
              "wappalyzer@crunchlabz.com" = mkExtensionEntry {
                id = "wappalyzer";
                pinned = true;
              };
              "uBlock0@raymondhill.net" = mkExtensionEntry {
                id = "ublock-origin";
                pinned = true;
              };
              "@react-devtools" = mkExtensionEntry {
                id = "react-developer-tools";
                pinned = true;
              };
              "{85860b32-02a8-431a-b2b1-40fbd64c9c69}" = "github-file-icons";
              "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = "return-youtube-dislikes";
              "{74145f27-f039-47ce-a470-a662b129930a}" = "clearurls";
              "github-no-more@ihatereality.space" = "github-no-more";
              "github-repository-size@pranavmangal" = "gh-repo-size";
              "@searchengineadremover" = "searchengineadremover";
              "jid1-BoFifL9Vbdl2zQ@jetpack" = "decentraleyes";
              "trackmenot@mrl.nyu.edu" = "trackmenot";
              "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}" = "stylus";
            };

            PasswordManagerEnabled = false;
            AutofillAddressEnabled = false;
            AutofillCreditCardEnabled = false;
            DisableAppUpdate = true;
            DisableFeedbackCommands = true;
            DisableFirefoxStudies = true;
            DisablePocket = true;
            DisableTelemetry = true;
            DontCheckDefaultBrowser = true;
            OfferToSaveLogins = false;
            EnableTrackingProtection = {
              Value = true;
              Locked = true;
              Cryptomining = true;
              Fingerprinting = true;
            };
          };

        profiles."default" = {
          containersForce = true;
          spacesForce = true;
          pinsForce = true;

          settings = {
            "zen.tabs.vertical.right-side" = true;
            "zen.view.use-single-toolbar" = false;
            "zen.view.compact.animate-sidebar" = false;
            "zen.workspaces.continue-where-left-off" = true;
            "zen.workspaces.natural-scroll" = true;
            "zen.view.compact.hide-tabbar" = true;
            "zen.view.compact.hide-toolbar" = false;
            "zen.welcome-screen.seen" = true;
          };

          containers = {
            Work = {
              id = 2;
              color = "green";
              icon = "briefcase";
            };
          };

          spaces = {
            "Pierre" = {
              id = "572910e1-4468-4832-a869-0b3a93e2f165";
              position = 1000;
              icon = "🪨";
            };
            "Work" = {
              id = "2441acc9-79b1-4afb-b582-ee88ce554ec0";
              container = 2;
              position = 1001;
              icon = "💼";
            };
          };

          search = {
            force = true;
            default = "google";
            engines = {
              bing.metaData.hidden = "true";
              duckDuckGo.metaData.hidden = "true";
              wikipedia.metaData.hidden = "true";
              perplexity.metaData.hidden = "true";
              qwant.metaData.hidden = "true";

              "Nix Packages" = {
                urls = [
                  {
                    template = "https://search.nixos.org/packages";
                    params = [
                      {
                        name = "type";
                        value = "packages";
                      }
                      {
                        name = "channel";
                        value = "unstable";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                definedAliases = [ "np" ];
              };
              "Nix Options" = {
                urls = [
                  {
                    template = "https://search.nixos.org/options";
                    params = [
                      {
                        name = "channel";
                        value = "unstable";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                definedAliases = [ "nop" ];
              };
              "Home Manager Options" = {
                urls = [
                  {
                    template = "https://home-manager-options.extranix.com/";
                    params = [
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                      {
                        name = "release";
                        value = "master"; # unstable
                      }
                    ];
                  }
                ];
                definedAliases = [ "hmop" ];
              };
            };
          };
        };
      };
    }
    // optionalAttrs desktop.addons.stylix.enable {
      stylix.targets.zen-browser.profileNames = [ "default" ];
    };
  };
}
