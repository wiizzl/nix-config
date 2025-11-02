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
  options.my.apps.jetbrains.goland = {
    enable = mkEnableOption "Jetbrains Go IDE";
  };

  config = mkIf apps.jetbrains.goland.enable {
    environment.systemPackages = with pkgs; [
      jetbrains.goland
    ];
  };
}
