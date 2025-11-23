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
  options.my.apps.file-manager.dolphin = {
    enable = mkEnableOption "Dolphin file manager";
  };

  config = mkIf apps.file-manager.dolphin.enable {
    home-manager.users.${user.name} = {
      home.packages = with pkgs; [
        kdePackages.dolphin
      ];
    };
  };
}
