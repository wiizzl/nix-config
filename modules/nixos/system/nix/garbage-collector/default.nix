{ config, lib, ... }:

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
  options.my.system.nix.garbage-collector = {
    enable = mkEnableOption "Enable ly display manager";
    dates = mkOption {
      type = types.str;
      default = "weekly";
      description = "When to run the garbage collector";
    };
    days = mkOption {
      type = types.int;
      default = 7;
      description = "Number of days after which to delete old generations";
    };
    auto-optimise-store = mkOption {
      type = types.bool;
      default = false;
      description = "Automatically optimise the Nix store after garbage collection";
    };
  };

  config = mkIf system.nix.garbage-collector.enable {
    nix = {
      gc = {
        automatic = true;
        dates = system.nix.garbage-collector.dates;
        options = "--delete-older-than ${toString system.nix.garbage-collector.days}d";
      };

      settings.auto-optimise-store = system.nix.garbage-collector.auto-optimise-store;
    };
  };
}
