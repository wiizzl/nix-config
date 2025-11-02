{ config, lib, ... }:

let
  inherit (lib) mkOption types;
  inherit (config.my) system;
in
{
  options.my.system.networking.hostname = mkOption {
    type = types.str;
    default = "nixos";
    description = "System hostname";
  };

  config = {
    networking.hostName = system.networking.hostname;
  };
}
