{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) cli user;
in
{
  options.my.cli.just = {
    enable = mkEnableOption "just";
  };

  config = mkIf cli.just.enable {
    home-manager.users.${user.name} = {
      home.packages = with pkgs; [
        just
      ];
    };
  };
}
