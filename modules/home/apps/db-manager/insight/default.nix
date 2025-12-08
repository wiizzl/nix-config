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
  options.my.apps.db-manager.insight = {
    enable = mkEnableOption "Redis Insight";
  };

  config = mkIf apps.db-manager.insight.enable {
    home-manager.users.${user.name} = {
      home.packages = with pkgs; [
        redisinsight
      ];
    };
  };
}
