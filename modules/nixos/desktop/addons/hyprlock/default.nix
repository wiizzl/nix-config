{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) desktop;
in
{
  options.my.desktop.addons.hyprlock = {
    enable = mkEnableOption "hyprlock";
  };

  config = mkIf desktop.addons.hyprlock.enable {
    security.pam.services.hyprlock = {
      enable = true;
    };
  };
}
