{
  pkgs,
  config,
  lib,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) apps user;
in
{
  options.my.apps.social.thunderbird = {
    enable = mkEnableOption "Thunderbird email client";
  };

  config = mkIf apps.social.thunderbird.enable {
    home-manager.users.${user.name} = {
      home.packages = with pkgs; [
        thunderbird
      ];
    };
  };
}
