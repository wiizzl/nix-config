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
  options.my.system.services.keyring = {
    enable = mkEnableOption "Enable Keyring";
    seahorse = mkOption {
      type = types.bool;
      default = false;
      description = "Enable seahorse GUI";
    };
  };

  config = mkIf system.services.keyring.enable {
    services.gnome.gnome-keyring.enable = true;
    programs.seahorse.enable = system.services.keyring.seahorse;
  };
}
