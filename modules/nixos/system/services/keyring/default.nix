{
  config,
  lib,
  pkgs,
  ...
}:

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
    environment.systemPackages = with pkgs; [
      libsecret
    ];

    services.gnome.gnome-keyring.enable = true;
    security.pam.services.greetd.enableGnomeKeyring = true;

    programs.seahorse = mkIf system.services.keyring.seahorse.enable {
      enable = true;
    };
  };
}
