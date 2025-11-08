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
          window.padding = {
            x = 22;
            y = 22;
          };
          cursor = {
            style = {
              shape = "Beam";
              blinking = "Always";
            };
            vi_mode_style.shape = "Block";
            blink_interval = 700;
          };
        };
      };
    };
  };
}
