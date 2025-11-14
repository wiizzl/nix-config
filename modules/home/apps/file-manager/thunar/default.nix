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
  options.my.apps.file-manager.thunar = {
    enable = mkEnableOption "Thunar file manager";
  };

  config = mkIf apps.file-manager.thunar.enable {
    home-manager.users.${user.name} = {
      home.packages = with pkgs; [
        xfce.thunar
        xfce.thunar-archive-plugin
        xfce.tumbler
      ];
    };
  };
}
