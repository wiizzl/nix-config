{
  pkgs,
  config,
  lib,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) apps;
in
{
  options.my.apps.browser.firefox = {
    enable = mkEnableOption "Firefox browser";
  };

  config = mkIf apps.browser.firefox.enable {
    environment.systemPackages = with pkgs; [
      firefox
    ];
  };
}
