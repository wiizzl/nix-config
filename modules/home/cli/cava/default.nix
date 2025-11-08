{ config, lib, ... }:

let
  inherit (lib) mkIf optionalAttrs;
  inherit (config.my) cli desktop user;
in
{
  config = mkIf cli.cava.enable {
    home-manager.users.${user.name} = {
        programs.cava = {
          enable = true;

          settings = {
            general.framerate = 60;
          };
        };
      } // optionalAttrs desktop.addons.stylix.enable {
        stylix.targets.cava.rainbow.enable = true;
      };
  };
}
