{
  config,
  lib,
  inputs,
  pkgs,
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
      imports = [ inputs.vicinae.homeManagerModules.default ];

      services.vicinae = {
        enable = true;
        package = inputs.vicinae.packages.${pkgs.stdenv.hostPlatform.system}.default;

        autoStart = true;
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
      };
    };
  };
}
