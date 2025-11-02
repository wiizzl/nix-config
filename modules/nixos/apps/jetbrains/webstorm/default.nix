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
  options.my.apps.jetbrains.webstorm = {
    enable = mkEnableOption "Jetbrains Web IDE";
  };

  config = mkIf apps.jetbrains.webstorm.enable {
    environment.systemPackages = with pkgs; [
      jetbrains.webstorm
    ];
  };
}
