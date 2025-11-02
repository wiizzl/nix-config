{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) system;
in
{
  options.my.system.allow.broken = {
    enable = mkEnableOption "broken packages";
  };

  config = mkIf system.allow.broken.enable {
    nixpkgs.config.allowBroken = true;
  };
}
