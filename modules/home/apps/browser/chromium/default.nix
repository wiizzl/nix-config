{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) apps user;
in
{
  options.my.apps.browser.chromium = {
    enable = mkEnableOption "Chromium browser";
  };

  config = mkIf apps.browser.chromium.enable {
    home-manager.users.${user.name} = {
      programs.chromium = {
        enable = true;

        package = pkgs.ungoogled-chromium;

        extensions = [
          { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
        ];
      };
    };
  };
}
