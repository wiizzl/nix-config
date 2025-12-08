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
  options.my.apps.db-manager.compass = {
    enable = mkEnableOption "MongoDB Compass";
  };

  config = mkIf apps.db-manager.compass.enable {
    home-manager.users.${user.name} = {
      home.packages = with pkgs; [
        mongodb-compass
      ];
    };
  };
}
