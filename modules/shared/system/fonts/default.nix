{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf types;
  inherit (config.my) system;
in
{
  options.my.system.fonts = {
    enable = mkEnableOption "fonts";
    default = mkEnableOption "default fonts";
  };

  config = mkIf system.fonts.enable {
    fonts = {
      packages = with pkgs; [
        # TODO: add fonts
      ];

      enableDefaultPackages = system.fonts.default;
    };
  };
}
