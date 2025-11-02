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
  options.my.apps.social.thunderbird = {
    enable = mkEnableOption "Thunderbird email client";
  };

  config = mkIf apps.social.thunderbird.enable {
    environment.systemPackages = with pkgs; [
      thunderbird
    ];
  };
}
