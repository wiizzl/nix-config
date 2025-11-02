{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkOption
    mkIf
    types
    ;
  inherit (config.my) system;
in
{
  options.my.system.fonts = {
    enable = mkEnableOption "Enable fonts";
    default = mkOption {
      type = types.bool;
      default = false;
      description = "Enable default fonts";
    };
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
