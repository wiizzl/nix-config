{
  pkgs,
  config,
  lib,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) apps user;
in
{
  options.my.apps.media.mpv = {
    enable = mkEnableOption "MPV media player";
  };

  config = mkIf apps.media.mpv.enable {
    home-manager.users.${user.name} = {
      home.packages = with pkgs; [
        mpv
      ];
    };
  };
}
