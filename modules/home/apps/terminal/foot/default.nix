{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) apps user;
in
{
  options.my.apps.terminal.foot = {
    enable = mkEnableOption "foot terminal emulator";
  };

  config = mkIf apps.terminal.foot.enable {
    home-manager.users.${user.name} = {
      programs.foot = {
        enable = true;

        settings = {
          pad = "8x8";

          scrollback = {
            lines = 100000;
          };
        };
      };
    };
  };
}
