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
  options.my.apps.social.nixcord = {
    enable = mkEnableOption "Enable NixCord";
    vesktop.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable Vesktop client";
    };
    discord.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable Discord client";
    };
  };

  config = mkIf apps.social.nixcord.enable {
    home-manager.users.${user.name} = {
      imports = [ inputs.nixcord.homeModules.nixcord ];

      stylix = mkIf desktop.addons.stylix.enable {
        targets.nixcord.enable = false;
      };

      programs.nixcord = {
        enable = true;

        discord.enable = apps.social.nixcord.discord.enable;
        vesktop = {
          enable = apps.social.nixcord.vesktop.enable;
          useSystemVencord = false;
        };

        quickCss = "@import url('https://catppuccin.github.io/discord/dist/catppuccin-mocha-mauve.theme.css');";

        config = {
          useQuickCss = true;
          frameless = true;

          plugins = {
            youtubeAdblock.enable = true;
            vencordToolbox.enable = true;
            noTrack = {
              enable = true;
              disableAnalytics = true;
            };
            fakeNitro.enable = true;
            callTimer.enable = true;
            friendsSince.enable = true;
            shikiCodeblocks.enable = true;
            voiceMessages.enable = true;
            messageLogger.enable = true;
          };
        };
      };
    };
  };
}
