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
  options.my.apps.media.kdenlive = {
    enable = mkEnableOption "KDEnlive Video Editor";
  };

  config = mkIf apps.media.kdenlive.enable {
    home-manager.users.${user.name} = {
      home.packages = with pkgs; [
        kdePackages.kdenlive
      ];
    };
  };
}
