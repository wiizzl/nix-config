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
  options.my.apps.jetbrains.phpstorm = {
    enable = mkEnableOption "Jetbrains PHP IDE";
  };

  config = mkIf apps.jetbrains.phpstorm.enable {
    environment.systemPackages = with pkgs; [
      jetbrains.phpstorm
    ];
  };
}
