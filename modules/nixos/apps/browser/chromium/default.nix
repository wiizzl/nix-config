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
  options.my.apps.browser.chromium = {
    enable = mkEnableOption "Chromium browser";
  };

  config = mkIf apps.browser.chromium.enable {
    environment.systemPackages = with pkgs; [
      ungoogled-chromium
    ];
  };
}
