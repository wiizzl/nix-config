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
  options.my.apps.media.vlc = {
    enable = mkEnableOption "VLC media player";
  };

  config = mkIf apps.media.vlc.enable {
    environment.systemPackages = with pkgs; [
      vlc
    ];
  };
}
