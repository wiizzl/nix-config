{ config, lib, ... }:

let
  inherit (lib) mkIf;
  inherit (config.my) desktop user;
in
{
  config = mkIf desktop.addons.hyprlock.enable {
    home-manager.users.${user.name} = {
      programs.hyprlock = {
        enable = true;

        settings = {

        };
      };
    };
  };
}
