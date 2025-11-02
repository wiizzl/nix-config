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
  options.my.apps.media.mpv = {
    enable = mkEnableOption "MPV media player";
  };

  config = mkIf apps.media.mpv.enable {
    environment.systemPackages = with pkgs; [
      mpv
    ];
  };
}
