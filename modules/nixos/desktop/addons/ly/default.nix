{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) desktop;
in
{
  options.my.desktop.addons.ly = {
    enable = mkEnableOption "ly display manager";
  };

  config = mkIf desktop.addons.ly.enable {
    services.displayManager.ly = {
      enable = true;
    };
  };
}
