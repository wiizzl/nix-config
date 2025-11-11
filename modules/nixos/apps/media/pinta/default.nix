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
  options.my.apps.media.pinta = {
    enable = mkEnableOption "Pinta";
  };

  config = mkIf apps.media.pinta.enable {
    environment.systemPackages = with pkgs; [
      pinta
    ];
  };
}
