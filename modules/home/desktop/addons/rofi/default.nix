{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkIf;
  inherit (config.my) desktop user;
in
{
  config = mkIf desktop.addons.rofi.enable {
    home-manager.users.${user.name} = {
      programs.rofi = {
        enable = true;
        modes = [ "drun" ];

        plugins = with pkgs; [
          rofi-calc
        ];

        extraConfig = {
          show-icons = true;

          drun-display-format = "{icon} {name}";
          display-drun = " Apps";
        };
      };
    };
  };
}
