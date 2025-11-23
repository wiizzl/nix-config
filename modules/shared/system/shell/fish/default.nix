{ config, lib, ... }:

let

  inherit (lib) mkEnableOption mkIf optionalAttrs;
  inherit (config.my) system cli;

  aliases = import ../aliases.nix;
in
{
  options.my.system.shell.fish = {
    enable = mkEnableOption "Fish shell";
  };

  config = mkIf system.shell.fish.enable {
    programs.fish = {
      enable = true;

      shellAliases =
        aliases.system
        // optionalAttrs cli.git.enable aliases.git
        // optionalAttrs system.utils.enable (aliases.bat // aliases.eza);

      interactiveShellInit = ''
        set fish_greeting
      '';
    };
  };
}
