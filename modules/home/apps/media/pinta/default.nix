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
  options.my.apps.media.pinta = {
    enable = mkEnableOption "Pinta";
  };

  config = mkIf apps.media.pinta.enable {
    home-manager.users.${user.name} = {
      home.packages = with pkgs; [
        pinta
      ];
    };
  };
}
