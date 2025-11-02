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
  options.my.apps.obs = {
    enable = mkEnableOption "Open Broadcaster Software (OBS) Studio";
  };

  config = mkIf apps.obs.enable {
    environment.systemPackages = with pkgs; [
      obs-studio
    ];
  };
}
