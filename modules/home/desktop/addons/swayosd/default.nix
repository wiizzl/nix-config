{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) desktop user;
in
{
  options.my.desktop.addons.swayosd = {
    enable = mkEnableOption "Sway OSD";
  };

  config = mkIf desktop.addons.swayosd.enable {
    home-manager.users.${user.name} = {
      services.swayosd = {
        enable = true;
        topMargin = 1.0;
      };
    };
  };
}
