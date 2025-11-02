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
  options.my.apps.jetbrains.android-studio = {
    enable = mkEnableOption "Jetbrains Android Studio IDE";
  };

  config = mkIf apps.jetbrains.android-studio.enable {
    environment.systemPackages = with pkgs; [
      android-studio
    ];
  };
}
