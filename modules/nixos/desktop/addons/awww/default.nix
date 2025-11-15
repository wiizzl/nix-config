{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) desktop;
in
{
  options.my.desktop.addons.awww = {
    enable = mkEnableOption "awww wallpaper manager";
  };

  config = mkIf desktop.addons.awww.enable {
    environment.systemPackages = [
      inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
    ];
  };
}
