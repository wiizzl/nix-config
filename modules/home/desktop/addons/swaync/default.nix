{ config, lib, ... }:

let
  inherit (lib) mkIf optionalAttrs;
  inherit (config.my) desktop user;
in
{
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
