{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
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
        nerd-fonts.jetbrains-mono
      ];

      enableDefaultPackages = system.fonts.default;
    };
  };
}
