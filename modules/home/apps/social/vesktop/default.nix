{
  config,
  lib,
  inputs,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkOption
    mkIf
    types
    ;
  inherit (config.my) apps desktop user;
in
{
  options.my.apps.social.vesktop = {
    enable = mkEnableOption "Enable Vesktop Discord client";
  };

  config = mkIf apps.social.nixcord.enable {
    home-manager.users.${user.name} = {
      programs.vesktop = {
        enable = true;

        settings = {
          discordBranch = "stable";
          minimizeToTray = false;
          arRPC = true;
        };

        vencord = {
          settings = {
            autoUpdate = false;
            autoUpdateNotification = false;

            frameless = true;
            useQuickCss = true;
            disableMinSize = true;

            plugins = {
              VoiceMessages.enabled = true;
              ShikiCodeblocks.enabled = true;
              CallTimer.enabled = true;
              FakeNitro.enabled = true;
              AlwaysAnimate.enabled = true;
              AlwaysExpandRoles.enabled = true;
              AlwaysTrust.enabled = true;
              BetterSessions.enabled = true;
              CrashHandler.enabled = true;
              FixImagesQuality.enabled = true;
              PlatformIndicators.enabled = true;
              ReplyTimestamp.enabled = true;
              ShowHiddenChannels.enabled = true;
              ShowHiddenThings.enabled = true;
              VencordToolbox.enabled = true;
              WebKeybinds.enabled = true;
              WebScreenShareFixes.enabled = true;
              YoutubeAdblock.enabled = true;
              BadgeAPI.enabled = true;
              NoTrack = {
                enabled = true;
                disableAnalytics = true;
              };
              Settings = {
                enabled = true;
                settingsLocation = "aboveNitro";
              };
            };
          };
        };
      };
    };
  };
}
