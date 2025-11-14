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
  options.my.apps.dbeaver = {
    enable = mkEnableOption "DBeaver Database Manager";
  };

  config = mkIf apps.dbeaver.enable {
    home-manager.users.${user.name} = {
      home.packages = with pkgs; [
        dbeaver-bin
      ];
    };
  };
}
