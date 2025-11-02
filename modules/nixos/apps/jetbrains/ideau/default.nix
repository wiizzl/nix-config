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
  options.my.apps.jetbrains.ideau = {
    enable = mkEnableOption "Jetbrains Java/Kotlin IDE";
  };

  config = mkIf apps.jetbrains.ideau.enable {
    environment.systemPackages = with pkgs; [
      jetbrains.idea-ultimate
    ];
  };
}
