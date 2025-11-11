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
  options.my.apps.media.kdenlive = {
    enable = mkEnableOption "KDEnlive Video Editor";
  };

  config = mkIf apps.media.kdenlive.enable {
    environment.systemPackages = with pkgs; [
      kdePackages.kdenlive
    ];
  };
}
