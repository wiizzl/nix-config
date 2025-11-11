{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) apps;
in
{
  options.my.apps.media.localsend = {
    enable = mkEnableOption "LocalSend";
  };

  config = mkIf apps.media.localsend.enable {
    programs.localsend = {
      enable = true;
      openFirewall = true;
    };
  };
}
