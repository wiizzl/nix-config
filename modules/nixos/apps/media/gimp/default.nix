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
  options.my.apps.media.gimp = {
    enable = mkEnableOption "GNU Image Manipulation Program (GIMP)";
  };

  config = mkIf apps.media.gimp.enable {
    environment.systemPackages = with pkgs; [
      gimp
    ];
  };
}
