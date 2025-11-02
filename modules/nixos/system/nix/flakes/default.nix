{ config, lib, ... }:

let
  inherit (lib) mkOption types;
  inherit (lib.extraMkOptions) mkOpt;

  inherit (config.my) system;
in
{
  options.my.system.nix.flakes = {
    extra-options = mkOpt types.str '''' "Flakes extra-options";
  };

  config = {
    nix = {
      settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      extraOptions = system.nix.flakes.extra-options;
    };
  };
}
