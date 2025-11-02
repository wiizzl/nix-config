{ config, lib, ... }:

let
  inherit (lib) types;
  inherit (lib.extraMkOptions) mkOpt;

  inherit (config.my) system;
in
{
  options.my.system.locale = {
    keymap = mkOpt types.str "en" "Keymap for the console";
    default-locale = mkOpt types.str "en_US.UTF-8" "The default system locale";
    extra-locale = mkOpt types.str "en_US.UTF-8" "The default system locale";
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
