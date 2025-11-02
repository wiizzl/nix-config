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
  options.my.apps.social.slack = {
    enable = mkEnableOption "Slack client";
  };

  config = mkIf apps.social.slack.enable {
    environment.systemPackages = with pkgs; [
      slack
    ];
  };
}
