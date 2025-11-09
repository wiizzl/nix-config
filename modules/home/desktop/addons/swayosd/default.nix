{ config, lib, ... }:

let
  inherit (lib) mkIf;
  inherit (config.my) desktop user;
in
{
  config = mkIf desktop.addons.swayosd.enable {
    home-manager.users.${user.name} = {
      services.swayosd = {
        enable = true;
        topMargin = 1.0;
      };
    };
  };
}
