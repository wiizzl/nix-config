{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) cli user;
in
{
  options.my.cli.fastfetch = {
    enable = mkEnableOption "fastfetch";
  };

  config = mkIf cli.fastfetch.enable {
    home-manager.users.${user.name} = {
      programs.fastfetch = {
        enable = true;
      };
    };
  };
}
