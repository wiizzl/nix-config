{
  pkgs,
  config,
  lib,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) apps;
in
{
  options.my.apps.social.element = {
    enable = mkEnableOption "Element matrix client";
  };

  config = mkIf apps.social.element.enable {
    environment.systemPackages = with pkgs; [
      element-desktop
    ];
  };
}
