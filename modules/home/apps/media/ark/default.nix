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
  options.my.apps.media.ark = {
    enable = mkEnableOption "Ark file archiver";
  };

  config = mkIf apps.media.ark.enable {
    home-manager.users.${user.name} = {
      home.packages = with pkgs; [
        kdePackages.ark
      ];
    };
  };
}
