{ config, lib, ... }:

let
  inherit (lib) types;
  inherit (lib.extraMkOptions) mkOpt;

  inherit (config.my) system;
in
{
  options.my.system.networking.hostname = mkOpt types.str "nixos" "System hostname";

  config = {
    networking.hostName = system.networking.hostname;
  };
}
