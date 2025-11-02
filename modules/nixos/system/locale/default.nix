{ config, lib, ... }:

let
  inherit (lib) mkOption types;
  inherit (config.my) system;
in
{
  options.my.system.locale = {
    keymap = mkOption {
      type = types.str;
      default = "en";
      description = "Keymap for the console";
    };
    default-locale = mkOption {
      type = types.str;
      default = "en_US.UTF-8";
      description = "The default system locale";
    };
    extra-locale = mkOption {
      type = types.str;
      default = "en_US.UTF-8";
      description = "The default system locale";
    };
  };

  config = {
    console.keyMap = system.locale.keymap;

    i18n = {
      defaultLocale = system.locale.default-locale;

      extraLocaleSettings = {
        LC_ADDRESS = system.locale.extra-locale;
        LC_IDENTIFICATION = system.locale.extra-locale;
        LC_MEASUREMENT = system.locale.extra-locale;
        LC_MONETARY = system.locale.extra-locale;
        LC_NAME = system.locale.extra-locale;
        LC_NUMERIC = system.locale.extra-locale;
        LC_PAPER = system.locale.extra-locale;
        LC_TELEPHONE = system.locale.extra-locale;
        LC_TIME = system.locale.extra-locale;
        LC_CTYPE = system.locale.extra-locale;
      };
    };
  };
}
