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
  options.my.apps.suite.onlyoffice = {
    enable = mkEnableOption "OnlyOffice suite";
  };

  config = mkIf apps.suite.onlyoffice.enable {
    home-manager.users.${user.name} = {
      home.packages = with pkgs; [
        onlyoffice-desktopeditors
      ];
    };
  };
}
