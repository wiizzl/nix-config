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
  options.my.apps.media.gimp = {
    enable = mkEnableOption "GNU Image Manipulation Program (GIMP)";
  };

  config = mkIf apps.media.gimp.enable {
    home-manager.users.${user.name} = {
      home.packages = with pkgs; [
        gimp
      ];
    };
  };
}
