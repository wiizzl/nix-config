{
  pkgs,
  config,
  lib,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) desktop;
in
{
  options.my.desktop.addons.swaync = {
    enable = mkEnableOption "Sway Notifications Center (swaync)";
  };

  config = mkIf desktop.addons.swaync.enable {
    environment.systemPackages = with pkgs; [
      swaynotificationcenter
      libnotify
    ];
  };
}
