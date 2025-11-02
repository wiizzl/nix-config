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
  options.my.apps.jetbrains.datagrip = {
    enable = mkEnableOption "Jetbrains Database Manager";
  };

  config = mkIf apps.jetbrains.datagrip.enable {
    environment.systemPackages = with pkgs; [
      jetbrains.datagrip
    ];
  };
}
