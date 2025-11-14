{
  pkgs,
  config,
  lib,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) apps user;
in
{
  options.my.apps.social.slack = {
    enable = mkEnableOption "Slack client";
  };

  config = mkIf apps.social.slack.enable {
    home-manager.users.${user.name} = {
      home.packages = with pkgs; [
        slack
      ];
    };
  };
}
