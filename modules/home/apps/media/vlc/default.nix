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
  options.my.apps.media.vlc = {
    enable = mkEnableOption "VLC media player";
  };

  config = mkIf apps.media.vlc.enable {
    home-manager.users.${user.name} = {
      home.packages = with pkgs; [
        vlc
      ];
    };
  };
}
