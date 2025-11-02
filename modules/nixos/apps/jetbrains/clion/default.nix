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
  options.my.apps.jetbrains.clion = {
    enable = mkEnableOption "Enable Jetbrains C/C++ IDE";
  };

  config = mkIf apps.jetbrains.clion.enable {
    environment.systemPackages = with pkgs; [
      jetbrains.clion
    ];
  };
}
