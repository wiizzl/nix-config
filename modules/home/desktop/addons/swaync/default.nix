{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf optionalAttrs;
  inherit (config.my) desktop user;
in
{
  options.my.desktop.addons.swaync = {
    enable = mkEnableOption "Sway Notifications Center (swaync)";
  };

  config = mkIf desktop.addons.swaync.enable {
    home-manager.users.${user.name} = {
      services.swaync = {
        enable = true;

        settings = { };
      };
    }
    // optionalAttrs desktop.addons.stylix.enable {
      stylix.targets.swaync.enable = false;
    };
  };
}
