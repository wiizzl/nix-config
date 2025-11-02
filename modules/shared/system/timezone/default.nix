{ config, lib, ... }:

let
  inherit (lib) mkOption types;
  inherit (lib.extraMkOptions) mkOpt;

  inherit (config.my) system;
in
{
  options.my.system.timezone = mkOpt types.str "America/New_York" "System timezone";

  config = {
    time.timeZone = system.timezone;
  };
}
