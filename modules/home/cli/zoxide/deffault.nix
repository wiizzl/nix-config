{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) cli user;
in
{
  options.my.cli.zoxide = {
    enable = mkEnableOption "zoxide";
  };

  config = mkIf cli.zoxide.enable {
    home-manager.users.${user.name} = {
      programs.zoxide = {
        enable = true;
      };
    };
  };
}
