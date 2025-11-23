{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf optionalAttrs;
  inherit (config.my) system cli;

  aliases = import ../aliases.nix;
in
{
  options.my.system.shell.zsh = {
    enable = mkEnableOption "ZSH shell";
  };

  config = mkIf system.shell.zsh.enable {
    programs.zsh = {
      enable = true;

      shellAliases =
        aliases.system
        // optionalAttrs cli.git.enable aliases.git
        // optionalAttrs system.utils.enable (aliases.bat // aliases.eza);
    };
  };
}
