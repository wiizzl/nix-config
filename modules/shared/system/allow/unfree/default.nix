{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) system;
in
{
  options.my.system.allow.unfree = {
    enable = mkEnableOption "unfree packages";
  };

  config = mkIf system.allow.unfree.enable {
    nixpkgs.config.allowUnfree = true;
  };
}
