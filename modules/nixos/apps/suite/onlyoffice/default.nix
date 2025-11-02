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
  options.my.apps.suite.onlyoffice = {
    enable = mkEnableOption "OnlyOffice suite";
  };

  config = mkIf apps.suite.onlyoffice.enable {
    environment.systemPackages = with pkgs; [
      onlyoffice-desktopeditors
    ];
  };
}
