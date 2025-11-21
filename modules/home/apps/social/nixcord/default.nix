{
  config,
  lib,
  inputs,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf optionalAttrs;
  inherit (config.my) apps desktop user;
in
{
  options.my.apps.social.nixcord = {
    enable = mkEnableOption "NixCord";
    vesktop.enable = mkEnableOption "Vesktop client";
    discord.enable = mkEnableOption "Discord client";
  };

  config = mkIf apps.social.nixcord.enable {
    home-manager.users.${user.name} = {
      imports = [ inputs.nixcord.homeModules.nixcord ];

      programs.nixcord = {
        enable = true;

        discord.enable = apps.social.nixcord.discord.enable;
        vesktop = {
          enable = apps.social.nixcord.vesktop.enable;
          useSystemVencord = true;
        };

        quickCss = "@import url('https://catppuccin.github.io/discord/dist/catppuccin-mocha-mauve.theme.css');";

        config = {
          useQuickCss = true;

          plugins = {
            readAllNotificationsButton.enable = true;
            youtubeAdblock.enable = true;
            vencordToolbox.enable = true;
            gameActivityToggle.enable = true;
            noProfileThemes.enable = true;
            spotifyControls.enable = true;
            openInApp.enable = true;
            colorSighted.enable = true;
            fakeNitro.enable = true;
            callTimer.enable = true;
            friendsSince.enable = true;
            replyTimestamp.enable = true;
            shikiCodeblocks.enable = true;
            voiceMessages.enable = true;
            betterNotesBox = {
              enable = true;
              hide = true;
            };
            messageLogger = {
              enable = true;
              collapseDeleted = true;
              ignoreBots = true;
              ignoreSelf = true;
            };
          };
        };
      };
    }
    // optionalAttrs desktop.addons.stylix.enable {
      stylix.targets.nixcord.enable = false;
    };
  };
}
