{ config, lib, ... }:

let
  inherit (lib) mkIf;
  inherit (config.my) desktop user;
in
{
  config = mkIf desktop.addons.swaync.enable {
    home-manager.users.${user.name} =
      mkIf desktop.addons.stylix.enable {
        stylix.targets.swaync.enable = false;
      }
      // {
        services.swaync = {
          enable = true;

          settings = { };
        };
      };
  };
}
