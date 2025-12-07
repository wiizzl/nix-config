{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) system;
in
{
  options.my.system.nix.store = {
    enable = mkEnableOption "store optimisation";
  };

  config = mkIf system.nix.store.enable {
    nix.settings.auto-optimise-store = true;
  };
}
