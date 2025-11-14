{ config, lib, ... }:

let
  inherit (lib)
    mkEnableOption
    mkIf
    types
    ;
  inherit (lib.extraMkOptions) mkOpt;

  inherit (config.my) system;
in
{
  options.my.system.nix.garbage-collector = {
    enable = mkEnableOption "Garbage collector for Nix store";
    auto-optimise-store.enable = mkEnableOption "the automatic optimisation for the Nix store";
    dates = mkOpt types.str "weekly" "When to run the garbage collector";
    days = mkOpt types.int 7 "Number of days after which to delete old generations";
  };

  config = mkIf system.nix.garbage-collector.enable {
    nix = {
      gc = {
        automatic = true;
        dates = system.nix.garbage-collector.dates;
        options = "--delete-older-than ${toString system.nix.garbage-collector.days}d";
      };

      settings.auto-optimise-store = system.nix.garbage-collector.auto-optimise-store.enable;
    };
  };
}
