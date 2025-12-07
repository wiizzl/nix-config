{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) system;
in
{
  options.my.system.nix.optimisation = {
    enable = mkEnableOption "store optimisation";
  };

  config = mkIf system.nix.optimisation.enable {
    nix = {
      settings = {
        download-buffer-size = 200000000;
        auto-optimise-store = true; # May make rebuilds longer but less size
      };

      optimise.automatic = true;
    };
  };
}
