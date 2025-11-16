{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf optionalAttrs;
  inherit (config.my) cli desktop user;
in
{
  options.my.cli.cava = {
    enable = mkEnableOption "cava";
  };

  config = mkIf cli.cava.enable {
    home-manager.users.${user.name} = {
      programs.cava = {
        enable = true;

        settings = {
          general.framerate = 60;
        };
      };
    }
    // optionalAttrs desktop.addons.stylix.enable {
      stylix.targets.cava.rainbow.enable = true;
    };
  };
}
