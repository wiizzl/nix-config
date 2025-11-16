{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) cli user;
in
{
  options.my.cli.bottom = {
    enable = mkEnableOption "bottom";
  };

  config = mkIf cli.bottom.enable {
    home-manager.users.${user.name} = {
      programs.bottom = {
        enable = true;

        settings = {
          flags = {
            avg_cpu = true;
            temperature_type = "c";
          };

          colors = {
            low_battery_color = "red";
          };
        };
      };
    };
  };
}
