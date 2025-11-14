{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) apps user;
in
{
  options.my.apps.browser.firefox = {
    enable = mkEnableOption "Firefox browser";
  };

  config = mkIf apps.browser.firefox.enable {
    home-manager.users.${user.name} = {
      programs.firefox = {
        enable = true;
      };
    };
  };
}
