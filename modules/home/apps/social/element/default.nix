{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) apps user;
in
{
  options.my.apps.social.element = {
    enable = mkEnableOption "Element matrix client";
  };

  config = mkIf apps.social.element.enable {
    home-manager.users.${user.name} = {
      programs.element-desktop = {
        enable = true;
      };
    };
  };
}
