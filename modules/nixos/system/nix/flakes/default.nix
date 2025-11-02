{ config, lib, ... }:

let
  inherit (lib) mkOption types;
  inherit (config.my) system;
in
{
  options.my.system.nix.flakes = {
    extra-options = mkOption {
      type = types.str;
      default = '''';
      description = "Flakes extra-options";
    };
  };

  config = {
    nix = {
      settings.experimental-features = [
        # NOTE: You cant disable both of thoses because a lot depends on it
        "nix-command"
        "flakes"
      ];

      extraOptions = system.nix.flakes.extra-options;
    };
  };
}
