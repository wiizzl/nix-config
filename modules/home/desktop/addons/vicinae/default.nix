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

          # theme = {
          #   iconTheme = "Papirus-Dark";
          #   name = "gruvbox-dark-hard.json";
          # };

          window = {
            csd = true;
            opacity = 1;
            rounding = 0;
          };

          faviconService = "twenty";
          popToRootOnClose = true;

          rootSearch = {
            searchFiles = true;
          };
        };
      };
    };
  };
}
