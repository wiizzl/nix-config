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
  options.my.apps.dbeaver = {
    enable = mkEnableOption "DBeaver Database Manager";
  };

  config = mkIf apps.dbeaver.enable {
    environment.systemPackages = with pkgs; [
      dbeaver-bin
    ];
  };
}
