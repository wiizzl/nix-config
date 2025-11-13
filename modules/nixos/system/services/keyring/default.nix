{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) system;
in
{
  options.my.system.services.keyring = {
    enable = mkEnableOption "Enable Keyring";
    seahorse.enable = mkEnableOption "Seahorse GUI";
  };

  config = mkIf system.services.keyring.enable {
    services.gnome.gnome-keyring.enable = true;
    programs.seahorse.enable = system.services.keyring.seahorse.enable;
  };
}
