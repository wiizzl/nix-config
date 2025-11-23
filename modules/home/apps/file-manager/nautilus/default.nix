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
  options.my.apps.file-manager.nautilus = {
    enable = mkEnableOption "Nautilus file manager";
  };

  config = mkIf apps.file-manager.nautilus.enable {
    services.gvfs.enable = true;

    home-manager.users.${user.name} = {
      home.packages = with pkgs; [
        nautilus
      ];
    };
  };
}
