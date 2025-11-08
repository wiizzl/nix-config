{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) apps user;
in
{
  options.my.apps.terminal.alacritty = {
    enable = mkEnableOption "Alacritty terminal emulator";
  };

  config = mkIf apps.terminal.alacritty.enable {
    home-manager.users.${user.name} = {
      programs.alacritty = {
        enable = true;

        settings = {
          cursor.shape = "Beam";
        };
      };
    };
  };
}
