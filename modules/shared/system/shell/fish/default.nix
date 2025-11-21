{ config, lib, ... }:

let

  inherit (lib) mkEnableOption mkIf;
  inherit (config.my) system;
in
{
  options.my.system.shell.fish = {
    enable = mkEnableOption "Fish shell";
  };

  config = mkIf system.shell.fish.enable {
    programs.fish = {
      enable = true;

      interactiveShellInit = ''
        set fish_greeting
      '';
    };
  };
}
