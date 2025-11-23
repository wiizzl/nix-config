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
    programs.xfconf.enable = true;
    services.gvfs.enable = true;
    services.tumbler.enable = true;

    home-manager.users.${user.name} = {
      home.packages = with pkgs.xfce; [
        thunar
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };
}
