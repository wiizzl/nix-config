{
  config,
  lib,
  ...
}:

let
  inherit (lib) mkIf mkEnableOption;
  inherit (config.my) desktop user;
in
{
  options.my.desktop.addons.vicinae = {
    enable = mkEnableOption "Vicinae application launcher";
  };

  config = mkIf desktop.addons.vicinae.enable {
    home-manager.users.${user.name} = {
      programs.vicinae = {
        enable = true;

        systemd = {
          enable = true;
          autoStart = true;
        };

        useLayerShell = true;

        settings = {
          font = {
            normal = "JetBrainsMono NF";
            size = 12;
          };

          theme.name = "catppuccin-mocha";

          window = {
            csd = true;
            opacity = 0.95;
            rounding = 8;
          };

          faviconService = "twenty";
          popToRootOnClose = true;
          rootSearch.searchFiles = false;
        };

        # extensions = [
        #   (config.lib.vicinae.mkRayCastExtension {
        #     name = "gif-search";
        #     sha256 = "sha256-G7il8T1L+P/2mXWJsb68n4BCbVKcrrtK8GnBNxzt73Q=";
        #     rev = "4d417c2dfd86a5b2bea202d4a7b48d8eb3dbaeb1";
        #   })
        # ];
      };
    };
  };
}
