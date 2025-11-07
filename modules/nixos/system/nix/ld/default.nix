{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) system;
in
{
  options.my.system.nix.ld = {
    enable = mkEnableOption "ability to run unpatched dynamic binaries";
  };

  config = mkIf system.nix.ld.enable {
    programs.nix-ld.enable = true;
  };
}
