{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) desktop user;
in
{
  options.my.desktop.addons.rofi = {
    enable = mkEnableOption "Rofi app launcher";
  };

  config = mkIf desktop.addons.rofi.enable {
    home-manager.users.${user.name} = {
      stylix = mkIf desktop.addons.stylix.enable {
        targets.rofi.enable = false;
      };

      programs.rofi = {
        enable = true;
        modes = [ "drun" ];

        extraConfig = {
          show-icons = true;

          drun-display-format = "{icon} {name}";
          display-drun = " Apps";
        };

      };
    };
  };
}
