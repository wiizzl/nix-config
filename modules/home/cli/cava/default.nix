{ config, lib, ... }:

let
  inherit (lib) mkIf;
  inherit (config.my) cli desktop user;
in
{
  config = mkIf cli.cava.enable {
    home-manager.users.${user.name} =
      mkIf desktop.addons.stylix.enable {
        stylix.targets.cava.rainbow.enable = true;
      }
      // {
        programs.cava = {
          enable = true;

          settings = {
            general.framerate = 60;
          };
        };
      };
  };
}
