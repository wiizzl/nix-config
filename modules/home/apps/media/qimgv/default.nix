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
  options.my.apps.media.qimgv = {
    enable = mkEnableOption "QIMGV image viewer";
  };

  config = mkIf apps.media.qimgv.enable {
    home-manager.users.${user.name} = {
      home.packages = with pkgs; [
        qimgv
      ];
    };
  };
}
