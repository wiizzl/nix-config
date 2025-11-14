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
  options.my.apps.obs = {
    enable = mkEnableOption "Open Broadcaster Software (OBS) Studio";
  };

  config = mkIf apps.obs.enable {
    home-manager.users.${user.name} = {
      home.packages = with pkgs; [
        obs-studio
      ];
    };
  };
}
