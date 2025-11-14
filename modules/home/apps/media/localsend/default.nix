{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) apps user;
in
{
  options.my.apps.media.localsend = {
    enable = mkEnableOption "LocalSend";
  };

  config = mkIf apps.media.localsend.enable {
    home-manager.users.${user.name} = {
      home.packages = with pkgs; [
        localsend
      ];
    };

    networking.firewall = {
      allowedTCPPorts = [ 53317 ];

      allowedUDPPortRanges = [
        {
          from = 4000;
          to = 4007;
        }
        {
          from = 53315;
          to = 53318;
        }
        {
          from = 8000;
          to = 8010;
        }
      ];
    };

  };
}
